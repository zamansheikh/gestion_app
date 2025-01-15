import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../routes/routes.dart';
import '../../base/bottom_menu..dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  final _selectedRoomIndex = 0;
  List<String> reservedRooms = [
    'Room 1',
    'Room 2',
    'Room 3',
    'Room 4',
    'Room 5',
    'Room 6',
    'Room 7',
    'Room 8',
    'Room 9',
    'Room 10',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text('Reservations'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reservedRooms.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: _selectedRoomIndex == index
                                  ? Color(0xFFD80665)
                                  : Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(child: Text(reservedRooms[index])),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.revervationDetailScreen);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Room Name: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('Room ${index + 1}'),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const Row(
                                children: [
                                  Text('Check In: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('24th July 2021'),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const Row(
                                children: [
                                  Text('Check Out: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('26th July 2021'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(1),
    );
  }
}