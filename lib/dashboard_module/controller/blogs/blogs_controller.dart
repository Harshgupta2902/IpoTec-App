import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/modal/blogs/blogs_model.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';
import 'package:ipotec/utilities/dio/api_request.dart';

class BlogsController extends GetxController with StateMixin<BlogsModel> {
  RxBool isLoading = RxBool(false);
  int loadMoreCount = 1;

  getBlogs({String? offset, bool? hardLoad}) async {
    isLoading.value = true;

    final apiEndPoint = "${APIEndPoints.blogsV1}?offset=$offset";
    debugPrint("---------- $apiEndPoint getBlogs Start ----------");
    if (offset == '1') {
      change(null, status: RxStatus.loading());
    }
    if (hardLoad == true) {
      change(null, status: RxStatus.loading());
    }

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("BlogsController =>  getBlogs > Success ${response.data} ");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      if (offset == '1' || hardLoad == true) {
        debugPrint("Offset:::::::::::$offset::::::::::::;;insertion");
        final modal = BlogsModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      } else {
        debugPrint("Offset::::::::::$offset:::::::::::::;;adding");
        final modal = BlogsModel.fromJson(response.data);
        state?.articles?.addAll(modal.articles ?? []);
        change(state, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getBlogs End With Error ----------");
      debugPrint(" BlogsController =>  getBlogs > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint  getBlogs End ----------");
    }
  }
}
