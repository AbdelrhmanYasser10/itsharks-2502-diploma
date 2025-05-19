import 'package:dio/dio.dart';


abstract class DioHelper {
  static Dio? _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://fcm.googleapis.com/v1/projects/chatapp-itsharks/",
        connectTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! <= 505;
        },
      ),
    );
  }

  static Future<Response> postData({
    required String endpoint,
    String? accessToken,
    Map<String, dynamic>? body,
  }) async {
    _dio!.options.headers = {
      "Authorization":"Bearer $accessToken",
    };
    return await _dio!.post(
      endpoint,
      data: body,
    );
  }
}