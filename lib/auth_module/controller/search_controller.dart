// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:ipotec/auth_module/models/mf_gainers_model.dart';
// import 'package:ipotec/auth_module/models/search_model.dart';
// import 'package:ipotec/utilities/dio/api_end_points.dart';
// import 'package:ipotec/utilities/dio/api_request.dart';
//
// class SearchMfController extends GetxController with StateMixin<SearchModel> {
//   searchData({required String type, required String text}) async {
//     change(null, status: RxStatus.loading());
//     final apiEndPoint = "${APIEndPoints.search}?type=$type&text=$text";
//     debugPrint("---------- $apiEndPoint searchData Start ----------");
//     try {
//       final response = await getRequest(apiEndPoint: apiEndPoint);
//
//       debugPrint("SearchMfController => searchData > Success  $response");
//
//       final responseData = response.data is String ? jsonDecode(response.data) : response.data;
//
//       final modal = SearchModel.fromJson(responseData);
//       change(modal, status: RxStatus.success());
//     } catch (error) {
//       debugPrint("---------- $apiEndPoint searchData End With Error ----------");
//       debugPrint("SearchMfController => searchData > Error $error ");
//       change(null, status: RxStatus.error());
//     } finally {
//       debugPrint("---------- $apiEndPoint searchData End ----------");
//     }
//   }
// }
