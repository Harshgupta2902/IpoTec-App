import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/ipo_module/modal/bottom/sme_ipo_modal.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class SmeIpoController extends GetxController with StateMixin<SmeIpoModal> {
  getSmeData({required String type}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = '${APIEndPoints.sme}?type=$type';
    debugPrint("---------- $apiEndPoint getSmeData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("SmeIpoController => getSmeData > Success  $response");



      final responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final modal = SmeIpoModal.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getSmeData End With Error ----------");
      debugPrint("SmeIpoController => getSmeData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getSmeData End ----------");
    }
  }
}
