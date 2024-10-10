import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_forms_model.dart';
import 'package:ipotec/dashboard_module/modal/ipo_gmp_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoGmpController extends GetxController with StateMixin<IpoGmpModel> {
  getGmpData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.gmp;
    debugPrint("---------- $apiEndPoint getGmpData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoGmpController => getGmpData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = IpoGmpModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getGmpData End With Error ----------");
      debugPrint("IpoGmpController => getGmpData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getGmpData End ----------");
    }
  }
}
