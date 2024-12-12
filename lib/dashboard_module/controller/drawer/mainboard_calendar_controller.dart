import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/bottom/ipo_gmp_model.dart';
import 'package:ipotec/dashboard_module/controller/drawer/mainboard_calendar_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoCalendarController extends GetxController with StateMixin<MainboardCalendarModel> {
  getMainboardCalendar({required bool isSme}) async {
    final apiEndPoint = isSme ? APIEndPoints.smeCalendar : APIEndPoints.mainBoardCalendar;
    debugPrint("---------- $apiEndPoint getMainboardCalendar Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoCalendarController => getMainboardCalendar > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MainboardCalendarModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMainboardCalendar End With Error ----------");
      debugPrint("IpoCalendarController => getMainboardCalendar > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMainboardCalendar End ----------");
    }
  }
}
