import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/bottom/ipo_details_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MainBoardDetailsController extends GetxController with StateMixin<IpoDetailsModel> {
  getMainboardDetails({required String slug}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.ipoDetails}/$slug";
    debugPrint("---------- $apiEndPoint getMainboardDetails Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MainBoardDetailsController => getMainboardDetails > Success  $response");

      final modal = IpoDetailsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMainboardDetails End With Error ----------");
      debugPrint("MainBoardDetailsController => getMainboardDetails > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMainboardDetails End ----------");
    }
  }
}
