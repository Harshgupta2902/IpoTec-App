import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/bottom/mainboard_ipo_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MainBoardIpoController extends GetxController with StateMixin<MainboardIpoModel> {
  getMainboardData({required String type}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = '${APIEndPoints.ipo}?type=$type';
    debugPrint("---------- $apiEndPoint getMainboardData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MainBoardIpoController => getMainboardData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MainboardIpoModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMainboardData End With Error ----------");
      debugPrint("MainBoardIpoController => getMainboardData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMainboardData End ----------");
    }
  }
}
