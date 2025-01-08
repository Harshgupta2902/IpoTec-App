import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/ipo_module/modal/drawer/sme_ipo_subs_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class SmeIpoSubsController extends GetxController with StateMixin<SmeIpoSubsModel> {
  getSmeSubsData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.smeSubs;
    debugPrint("---------- $apiEndPoint getSmeSubsData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("SmeIpoSubsController => getSmeSubsData > Success  $response");


      final responseData = response.data is String ? jsonDecode(response.data) : response.data;
      final modal = SmeIpoSubsModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getSmeSubsData End With Error ----------");
      debugPrint("SmeIpoSubsController => getSmeSubsData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getSmeSubsData End ----------");
    }
  }
}
