import 'package:dio/dio.dart';

import '../constants/constants.dart';

abstract class DioHelper {
  static Dio? _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BASEURL,
        connectTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        headers: {
          "lang":"en",
        },
        validateStatus: (status) {
          return status! <= 505;
        },
      ),
    );
  }

  static Future<Response> getData({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    _dio!.options.headers = {
      "Authorization":token,
    };
    return await _dio!.get(
      endpoint,

      queryParameters: queryParams,
    );
  }

  static Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    return await _dio!.post(
      endpoint,
      data: body,
    );
  }
}
