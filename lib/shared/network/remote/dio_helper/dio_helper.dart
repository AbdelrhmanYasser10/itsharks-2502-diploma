import 'package:dio/dio.dart';

import '../constants/constants.dart';

abstract class DioHelper{
  static Dio? _dio;

  static void init(){
    _dio = Dio(
      BaseOptions(
        baseUrl: BASEURL,
        connectTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! <= 505;
        },
      ),
    );
  }

  static Future<Response> getData({
    required String endpoint,
    Map<String,dynamic>? queryParams,
  })async{
    return await _dio!.get(
        endpoint,
      queryParameters: queryParams,
    );
  }

}