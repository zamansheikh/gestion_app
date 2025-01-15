import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_app/controllers/calendar_controller.dart';
import 'package:gestion_app/helpers/date_utils.dart';
import 'package:gestion_app/helpers/logger.dart';
import 'package:get/get.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../utils/app_constants.dart';
import '../../base/bottom_menu..dart';
import '../../base/calender_cell.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int _selectedRoomIndex = 0;
  RxBool isAnyRoomAvailable = false.obs;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final List<int> _years = List.generate(50, (index) => 2000 + index);
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  final Map<DateTime, List<String>> _events = {
    DateTime(2025, 1, 4): ['Meeting with Team', 'Lunch with Friends'],
    DateTime(2023, 12, 17): ['Project Deadline'],
    DateTime(2023, 12, 30): ['Holiday Party'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<Widget> _buildCalendarDays(DateTime month) {
    final List<Widget> days = [];
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday;
    final totalDays = lastDayOfMonth.day;

    String roombookStart = "";
    String roombookEnd = "";
    String currentDate = DateUtilsx.getFormattedCurrentDate();
    if (controller.reservationModel.isNotEmpty) {
      for (var room in controller.reservationModel.first.reservations) {
        if (room.status == "Confirmed") {
          roombookStart = room.rooms.first.dfrom;
          roombookEnd = room.rooms.first.dto;
        }
      }
    }

    //! isBookedOrNot Method
    bool isBookedOrNot(int day) {
      String customDate = "$day/$_selectedMonth/$_selectedYear";
      if (controller.reservationModel.isNotEmpty) {
        if ((roombookStart.length > 3) && (roombookEnd.length > 3)) {
          if (DateUtilsx.isDateBetween(
              customDate, roombookStart, roombookEnd)) {
            return true;
          }
        } else {
          return false;
        }
      }
      return false;
    }

    //! getBookingStatus
    BookingStatus getBookingStatus(int day) {
      String customDate = "$day/$_selectedMonth/$_selectedYear";
      if (controller.reservationModel.isNotEmpty) {
        if (DateUtilsx.areDatesEqual(customDate, roombookStart)) {
          if (DateUtilsx.isDateBetween(
              currentDate, roombookStart, roombookEnd)) {
            return BookingStatus.runningStart;
          } else if (DateUtilsx.isDateFuture(roombookStart, roombookEnd)) {
            return BookingStatus.futureStart;
          } else {
            return BookingStatus.pastStart;
          }
        } else if (DateUtilsx.areDatesEqual(customDate, roombookEnd)) {
          if (DateUtilsx.isDateBetween(
              currentDate, roombookStart, roombookEnd)) {
            return BookingStatus.runningEnd;
          } else if (DateUtilsx.isDateFuture(roombookStart, roombookEnd)) {
            return BookingStatus.futureEnd;
          } else {
            return BookingStatus.pastEnd;
          }
        } else if (DateUtilsx.isDateBetween(
            customDate, roombookStart, roombookEnd)) {
          if (DateUtilsx.isDateBetween(
              currentDate, roombookStart, roombookEnd)) {
            return BookingStatus.running;
          } else if (DateUtilsx.isDateFuture(roombookStart, roombookEnd)) {
            return BookingStatus.future;
          } else {
            return BookingStatus.past;
          }
        }
      }
      return BookingStatus.none;
    }

    // Add empty cells for the first week
    for (int i = 1; i < firstDayOfWeek; i++) {
      days.add(const SizedBox());
    }

    // Add days of the month
    for (int day = 1; day <= totalDays; day++) {
      final currentDay = DateTime(month.year, month.month, day);
      if (isBookedOrNot(day)) {
        days.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = currentDay;
              });
            },
            child: CalendarCell(
              status: getBookingStatus(day),
              dayNumber: day,
            ),
          ),
        );
      } else {
        days.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = currentDay;
              });
            },
            child: CalendarCell(
              status: BookingStatus.none,
              dayNumber: day,
            ),
          ),
        );
      }
      // if (day == 2) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.none,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 4) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.pastStart,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 5) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.past,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 6) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.past,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 15) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.runningStart,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 16) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.running,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 17) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.running,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 18) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.runningEnd,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 29) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.futureStart,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // } else if (day == 30) {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.futureEnd,
      //         showBorder: true,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      //
      // } else {
      //   days.add(
      //     GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           _selectedDay = currentDay;
      //         });
      //       },
      //       child: CalendarCell(
      //         status: BookingStatus.none,
      //         dayNumber: day,
      //       ),
      //     ),
      //   );
      // }
    }

    return days;
  }

  final CalendarController controller = Get.put(CalendarController());

  @override
  void initState() {
    super.initState();
    getCurrectUserId();
  }

  getCurrectUserId() async {
    final userID = await PrefsHelper.getString(AppConstants.user);
    // String tempID = "6780bd86c85ef756e879baec";
    await controller.calendarReserve(id: userID);
    if (controller.calenderModel.isNotEmpty) {
      setState(() {
        isAnyRoomAvailable.value = true;
      });
    }

    if (isAnyRoomAvailable.value) {
      "Logged in User ID: $userID".logW();
      "Room available and found first ID: ${controller.calenderModel.first.id!}"
          .logW();
      await controller.reservationProperty(
        id: controller.calenderModel.first.id!, //"6785e3f04be08099a3543b8e",
        startDate: DateUtilsx.getStartDateOfMonth(),
        endDate: DateUtilsx.getEndDateOfMonth(),
      );
      setState(() {});
    }
  }

  getRoomDetailsByDate(
      {required String start,
      required String end,
      required String roomId}) async {
    if (isAnyRoomAvailable.value) {
      "Room available and found first ID: ${controller.calenderModel.first.id!}"
          .logW();
      await controller.reservationProperty(
        id: roomId,
        startDate: start,
        endDate: end,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reservation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.calenderModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                _selectedRoomIndex = index;
                              });
                              //Call API of ROOM HERE
                              if (isAnyRoomAvailable.value) {
                                "Room available and found for Room- : ${controller.calenderModel[index].roomName}"
                                    .logW();
                                // DateUtilsx.getEndDateFromMonthAndYear(_selectedMonth, _selectedYear).logE();
                                await controller.reservationProperty(
                                  id: controller
                                      .calenderModel[_selectedRoomIndex].id!,
                                  startDate:
                                      "01/$_selectedMonth/$_selectedYear",
                                  endDate:
                                      DateUtilsx.getEndDateFromMonthAndYear(
                                          _selectedMonth, _selectedYear),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: _selectedRoomIndex == index
                                    ? Color(0xFFD80665)
                                    : Color(0xFFE6E6E6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                  child: Text(
                                      '${controller.calenderModel[index].roomName}')),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            // Year, Month Dropdowns, and Today Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Today Button
                InkWell(
                  onTap: () {
                    setState(() {
                      _focusedDay = DateTime.now();
                      _selectedYear = _focusedDay.year;
                      _selectedMonth = _focusedDay.month;
                      _selectedDay = _focusedDay;
                    });
                    getRoomDetailsByDate(
                        start: DateUtilsx.getStartDateOfMonth(),
                        end: DateUtilsx.getEndDateOfMonth(),
                        roomId:
                            "${controller.calenderModel[_selectedRoomIndex].id}");
                  },
                  child: Container(
                    height: 35,
                    width: 60,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF333333)),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(child: Text("Today")),
                  ),
                ),

                // Year Dropdown
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF333333)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<int>(
                    value: _selectedYear,
                    items: _years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        _selectedYear = value!;
                        _focusedDay = DateTime(_selectedYear, _selectedMonth);
                      });
                      if (isAnyRoomAvailable.value) {
                        "Room available and found for Room- : ${controller.calenderModel[_selectedRoomIndex].roomName}"
                            .logW();
                        // DateUtilsx.getEndDateFromMonthAndYear(_selectedMonth, _selectedYear).logE();
                        await controller.reservationProperty(
                          id: controller.calenderModel[_selectedRoomIndex].id!,
                          startDate: "01/$_selectedMonth/$_selectedYear",
                          endDate: DateUtilsx.getEndDateFromMonthAndYear(
                              _selectedMonth, _selectedYear),
                        );
                      }
                    },
                    underline: SizedBox(),
                  ),
                ),

                // Month Dropdown
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF333333)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<int>(
                    value: _selectedMonth,
                    items: List.generate(_months.length, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text(_months[index]),
                      );
                    }),
                    onChanged: (value) async {
                      setState(() {
                        _selectedMonth = value!;
                        _focusedDay = DateTime(_selectedYear, _selectedMonth);
                      });
                      if (isAnyRoomAvailable.value) {
                        "Room available and found for Room- : ${controller.calenderModel[_selectedRoomIndex].roomName}"
                            .logW();
                        // DateUtilsx.getEndDateFromMonthAndYear(_selectedMonth, _selectedYear).logE();
                        await controller.reservationProperty(
                          id: controller.calenderModel[_selectedRoomIndex].id!,
                          startDate: "01/$_selectedMonth/$_selectedYear",
                          endDate: DateUtilsx.getEndDateFromMonthAndYear(
                              _selectedMonth, _selectedYear),
                        );
                      }
                    },
                    underline: SizedBox(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Days of the week row
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xffF2F5F7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Mon',
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('Tue',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold)),
                  Text('Wed',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold)),
                  Text('Thu',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold)),
                  Text('Fri',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold)),
                  Text('Sat',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold)),
                  Text('Sun',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Calendar Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: GridView.count(
                    crossAxisSpacing: 4.0,
                    crossAxisCount: 7,
                    children: _buildCalendarDays(firstDayOfMonth),
                  ),
                ),
              ),
            ),

            // Events Section
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Events for ${_selectedDay != null ? '${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}' : 'None'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (_selectedDay != null &&
                        _getEventsForDay(_selectedDay!).isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: _getEventsForDay(_selectedDay!).length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _getEventsForDay(_selectedDay!)[index],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Text('No events for this date.',
                          style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(0),
    );
  }
}
