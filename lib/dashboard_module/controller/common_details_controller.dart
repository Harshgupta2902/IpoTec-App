import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class CommonDetailsController extends GetxController with StateMixin<IpoDetailsModel> {
  getCommonDetails({required String slug}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.commonDetails}/$slug";
    debugPrint("---------- $apiEndPoint getCommonDetails Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("CommonDetailsController => getCommonDetails > Success  $response");

      final modal = IpoDetailsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getCommonDetails End With Error ----------");
      debugPrint("CommonDetailsController => getCommonDetails > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getCommonDetails End ----------");
    }
  }
}
