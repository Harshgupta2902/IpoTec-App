import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/models/mmi_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MmiController extends GetxController with StateMixin<MmiModel> {
  getMmiData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.mmi;
    debugPrint("---------- $apiEndPoint getMmiData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MmiController => getMmiData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MmiModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMmiData End With Error ----------");
      debugPrint("MmiController => getMmiData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMmiData End ----------");
    }
  }
}
