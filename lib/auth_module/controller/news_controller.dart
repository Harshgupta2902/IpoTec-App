import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/models/news_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class NewsController extends GetxController with StateMixin<NewsModel> {
  RxBool isLoading = RxBool(false);
  int loadMoreCount = 1;

  getNews({String? offset, bool? hardLoad}) async {
    isLoading.value = true;

    final apiEndPoint = "${APIEndPoints.news}?offset=$offset";
    debugPrint("---------- $apiEndPoint getNews Start ----------");
    if (offset == '1') {
      change(null, status: RxStatus.loading());
    }
    if (hardLoad == true) {
      change(null, status: RxStatus.loading());
    }

    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("NewsController =>  getNews > Success ${response.data} ");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      if (offset == '1' || hardLoad == true) {
        debugPrint("Offset:::::::::::$offset::::::::::::;;insertion");
        final modal = NewsModel.fromJson(responseData);
        change(modal, status: RxStatus.success());
      } else {
        debugPrint("Offset::::::::::$offset:::::::::::::;;adding");
        final modal = NewsModel.fromJson(responseData);
        state?.data?.addAll(modal.data ?? []);
        change(state, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getNews End With Error ----------");
      debugPrint(" NewsController =>  getNews > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint  getNews End ----------");
    }
  }
}
