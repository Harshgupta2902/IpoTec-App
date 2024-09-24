import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/search_modal.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class SearchResultsController extends GetxController with StateMixin<SearchModal> {
  getSearchResults({required String search}) async {
    change(null, status: RxStatus.empty());

    final apiEndPoint = "${APIEndPoints.search}?query=$search";
    debugPrint("---------- $apiEndPoint getSearchResults Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("SearchResultsController => getSearchResults > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = SearchModal.fromJson(response.data);
      change(modal, status: RxStatus.success());

      if (modal.content == []) {
        change(null, status: RxStatus.empty());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint getSearchResults End With Error ----------");
      debugPrint("SearchResultsController => getSearchResults > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getSearchResults End ----------");
    }
  }
}
