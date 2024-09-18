import 'package:dio/dio.dart';
import 'package:ipotec/utilities/dio/api_end_points.dart';

class NewClient {
  Dio init() {
    Dio dio = Dio();
    dio.options.baseUrl = APIEndPoints.base;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
