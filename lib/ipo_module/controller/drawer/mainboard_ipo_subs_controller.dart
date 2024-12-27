import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/ipo_module/modal/drawer/mainboard_ipo_subs_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MainBoardIpoSubsController extends GetxController with StateMixin<MainboardIpoSubsModel> {
  getMainBoardSubsData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.mainSubs;
    debugPrint("---------- $apiEndPoint getMainBoardSubsData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MainBoardIpoSubsController => getMainBoardSubsData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MainboardIpoSubsModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMainBoardSubsData End With Error ----------");
      debugPrint("MainBoardIpoSubsController => getMainBoardSubsData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMainBoardSubsData End ----------");
    }
  }
}
