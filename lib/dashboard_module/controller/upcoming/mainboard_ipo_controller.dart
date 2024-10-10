import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/upcoming/mainboard_ipo_model.dart';

import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MainBoardIpoController extends GetxController with StateMixin<MainboardIpoModel> {
  getMainboardData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.ipo;
    debugPrint("---------- $apiEndPoint getMainboardData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MainBoardIpoController => getMainboardData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = MainboardIpoModel.fromJson(response.data);
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
