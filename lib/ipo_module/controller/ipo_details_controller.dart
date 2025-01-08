import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/ipo_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoDetailsController extends GetxController with StateMixin<IpoDetailsModel> {
  getIpoData({required String slug}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.details}?slug=$slug";
    debugPrint("---------- $apiEndPoint getIpoData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoDetailsController => getIpoData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = IpoDetailsModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getIpoData End With Error ----------");
      debugPrint("IpoDetailsController => getIpoData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getIpoData End ----------");
    }
  }
}
