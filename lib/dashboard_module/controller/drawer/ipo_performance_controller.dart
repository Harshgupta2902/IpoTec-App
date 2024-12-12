import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/drawer/ipo_performance_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoPerformanceController extends GetxController with StateMixin<IpoPerformanceModel> {
  getPerformance() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.performance;
    debugPrint("---------- $apiEndPoint getPerformance Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoPerformanceController => getPerformance > Success  $response");


      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = IpoPerformanceModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getPerformance End With Error ----------");
      debugPrint("IpoPerformanceController => getPerformance > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getPerformance End ----------");
    }
  }
}
