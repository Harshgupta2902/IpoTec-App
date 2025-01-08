import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/models/mf_gainers_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MfGainersController extends GetxController with StateMixin<MfGainersModel> {
  getMfGainersData({required String type}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.mfGainers}?type=$type";
    debugPrint("---------- $apiEndPoint getMfGainersData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MfGainersController => getMfGainersData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MfGainersModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMfGainersData End With Error ----------");
      debugPrint("MfGainersController => getMfGainersData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMfGainersData End ----------");
    }
  }
}
