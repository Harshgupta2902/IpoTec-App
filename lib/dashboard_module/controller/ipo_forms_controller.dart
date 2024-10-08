import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_forms_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoFormsController extends GetxController with StateMixin<IpoFormsModel> {
  getFormsData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.forms;
    debugPrint("---------- $apiEndPoint getFormsData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoFormsController => getFormsData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = IpoFormsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getFormsData End With Error ----------");
      debugPrint("IpoFormsController => getFormsData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getFormsData End ----------");
    }
  }
}
