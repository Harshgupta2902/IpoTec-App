import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/default_model.dart';
import 'package:ipotec/utilities/common/core_update_handler.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class DefaultApiController extends GetxController with StateMixin<DefaultModel> {
  getDefaultData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.defaultApi;
    debugPrint("---------- $apiEndPoint getDefaultData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("DefaultApiController => getDefaultData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = DefaultModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getDefaultData End With Error ----------");
      debugPrint("DefaultApiController => getDefaultData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getDefaultData End ----------");
    }
  }
}
