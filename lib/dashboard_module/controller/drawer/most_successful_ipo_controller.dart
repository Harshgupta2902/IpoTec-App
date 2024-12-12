import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/drawer/most_successful_ipo_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class MostSuccessfulIpoController extends GetxController with StateMixin<MostSuccessfulIpoModel> {
  var isListingGainAsc = true.obs;
  var isCurrentGainAsc = true.obs;

  getMostSuccessfulIpo() async {
    change(null, status: RxStatus.loading());
    const apiEndPoint = APIEndPoints.mostSuccessfulIpo;
    debugPrint("---------- $apiEndPoint getMostSuccessfulIpo Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("MostSuccessfulIpoController => getMostSuccessfulIpo > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = MostSuccessfulIpoModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMostSuccessfulIpo End With Error ----------");
      debugPrint("MostSuccessfulIpoController => getMostSuccessfulIpo > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMostSuccessfulIpo End ----------");
    }
  }

  void sortByListingGain() {
    isListingGainAsc.value = !isListingGainAsc.value;
    state?.body?.sort((a, b) {
      final aGain = a.listingGainP ?? 0;
      final bGain = b.listingGainP ?? 0;
      return isListingGainAsc.value ? aGain.compareTo(bGain) : bGain.compareTo(aGain);
    });
  }

  // Sorting logic for Current Gain
  void sortByCurrentGain() {
    isCurrentGainAsc.value = !isCurrentGainAsc.value;
    state?.body?.sort((a, b) {
      final aGain = a.currentGainP ?? 0;
      final bGain = b.currentGainP ?? 0;
      return isCurrentGainAsc.value ? aGain.compareTo(bGain) : bGain.compareTo(aGain);
    });
  }
}
