import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/models/search_model.dart';
import 'package:ipotec/auth_module/models/tape_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class TapeController extends GetxController with StateMixin<TapeModel> {
  getTape() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.tape;
    debugPrint("---------- $apiEndPoint getTape Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("TapeController => getTape > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = TapeModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getTape End With Error ----------");
      debugPrint("TapeController => getTape > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getTape End ----------");
    }
  }
}
