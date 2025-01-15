import 'package:gestion_app/helpers/logger.dart';
import 'package:gestion_app/models/calender_model.dart';
import 'package:gestion_app/models/reservation_model.dart';
import 'package:get/get.dart';

import '../services/api_checker.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class CalendarController extends GetxController {
  RxBool calendarLoading = false.obs;
  RxList<CalenderModel> calenderModel = <CalenderModel>[].obs;

  calendarReserve({String id = ''}) async {
    calendarLoading(true);
    var response = await ApiClient.getData(ApiConstants.getPropertyById(id));
    if (response.statusCode == 200) {
      var data = response.body["data"];
      try {
        calenderModel.value = List<CalenderModel>.from(
            data.map((x) => CalenderModel.fromJson(x)));
        "Data converted: fromJson to Model".logW();
      } catch (e) {
        "Something wrong".logE();
      }
      calendarLoading(false);
    } else {
      calendarLoading(false);
      ApiChecker.checkApi(response);
    }
  }

  RxBool reservationLoading = false.obs;
  RxList<ReservationModel> reservationModel = <ReservationModel>[].obs;
  reservationProperty(
      {String id = '', String startDate = '', String endDate = ''}) async {
    reservationLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.reservationProperty(id, startDate, endDate),
    );

    if (response.statusCode == 200) {
      var data = response.body["data"];
      try {
        reservationModel.add(ReservationModel.fromJson(data));
        "Successfully Converted".logE();
      } catch (e) {
        e.toString().logE();
      }
      reservationLoading(false);
    } else {
      reservationLoading(false);
      ApiChecker.checkApi(response);
    }
  }
}
