import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class MessagingConfiguration{
static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

static String? _fcmToken;

static Future<void> _createNotificationChannel()async{
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_important_channel",
    "High Notification Important Channel",
    description: "This channel for local notifications",
    importance: Importance.max,
  );
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

static Future<void> configuration()async{
  // create channel
  await _createNotificationChannel();

  // Request Permission
  final notificationSettings = await FirebaseMessaging.instance.requestPermission();

  if(Platform.isIOS){
    if(
    notificationSettings.authorizationStatus == AuthorizationStatus.authorized
    || notificationSettings.authorizationStatus == AuthorizationStatus.provisional
    ){
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
         _fcmToken = await FirebaseMessaging.instance.getToken();
        log(_fcmToken.toString());
      }
    }
  }
  else{
    if(
    notificationSettings.authorizationStatus == AuthorizationStatus.authorized
        || notificationSettings.authorizationStatus == AuthorizationStatus.provisional
    ){
      _fcmToken = await FirebaseMessaging.instance.getToken();
      log(_fcmToken.toString());
    }
  }

  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher"
  );
  const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS:  iosInitializationSettings,
  );
  await _flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (details) {
    print(details.payload);
  },);

  FirebaseMessaging.onMessage.listen((event){
    _flutterLocalNotificationsPlugin.show(
      0,
      event.notification!.title,
      event.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "high_important_channel",
          "High Notification Important Channel",
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(

        ),
      ),
    );
  });
}

static String? getFCMToken ()=> _fcmToken;


}