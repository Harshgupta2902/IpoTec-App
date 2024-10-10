import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_subs_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class IpoSubsController extends GetxController with StateMixin<IpoSubsModel> {
  getSubsData() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.subs;
    debugPrint("---------- $apiEndPoint getSubsData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("IpoSubsController => getSubsData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = IpoSubsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getSubsData End With Error ----------");
      debugPrint("IpoSubsController => getSubsData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getSubsData End ----------");
    }
  }
}
