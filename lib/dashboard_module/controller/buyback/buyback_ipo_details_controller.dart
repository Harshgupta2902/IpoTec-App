import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/buyback/buyback_details_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class BuybackDetailsController extends GetxController with StateMixin<BuybackDetailsModel> {
  getBuybackDetails({required String slug}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.buybackDetails}/$slug";

    debugPrint("---------- $apiEndPoint getBuybackDetails Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("BuybackDetailsController => getBuybackDetails > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = BuybackDetailsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getBuybackDetails End With Error ----------");
      debugPrint("BuybackDetailsController => getBuybackDetails > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getBuybackDetails End ----------");
    }
  }
}
