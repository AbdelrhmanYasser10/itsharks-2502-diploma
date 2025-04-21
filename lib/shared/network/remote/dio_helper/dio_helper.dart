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

      ),
    );
  }

  static Future<Response> getData({
  required String endpoint,
})async{
    return await _dio!.get(endpoint);
  }

}