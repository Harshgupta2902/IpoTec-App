import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/models/stock_gainers_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class StockGainersController extends GetxController with StateMixin<StockGainersModel> {
  getStocksData({required String type}) async {
    change(null, status: RxStatus.loading());
    final apiEndPoint = "${APIEndPoints.stockGainers}?type=$type";
    debugPrint("---------- $apiEndPoint getStocksData Start ----------");
    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("StockGainersController => getStocksData > Success  $response");

      final responseData = response.data is String ? jsonDecode(response.data) : response.data;

      final modal = StockGainersModel.fromJson(responseData);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getStocksData End With Error ----------");
      debugPrint("StockGainersController => getStocksData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getStocksData End ----------");
    }
  }
}
