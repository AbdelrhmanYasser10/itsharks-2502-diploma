import 'dart:convert';
import 'dart:developer';

import 'package:chat_app_itsharks_25/services/dio_helper/dio_helper.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:dio/dio.dart';

Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/notification_key/chatapp-itsharks-2ad23bbf66c8.json',
  );
  final accountCredentials =
      auth.ServiceAccountCredentials.fromJson(jsonString);
  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);
  return client.credentials.accessToken.data;
}

Future<void> sendNotification({
  required String token, //fcm token
  required String title,
  required String body,
  required Map<String, dynamic> data,
}) async {
  String accessToken = await getAccessToken();
  Response response = await DioHelper.postData(
      endpoint: "messages:send",
      accessToken: accessToken,
      body: {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": data,
          'android': {
            'notification': {
              "sound": "custom_sound",
              'click_action':
                  'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
              'channel_id': 'high_importance_channel'
            },
          },
          'apns': {
            'payload': {
              'aps': {"sound": "custom_sound.caf", 'content-available': 1},
            },
          }
        }
      });
  if (response.statusCode == 200) {
    log("Notification Send successfully");
  } else {
    print(response.data);
    log("Notification Send Error");
  }
}
