import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_app_itsharks_25/main.dart';
import 'package:chat_app_itsharks_25/services/notification_serivces/send_notification_serivce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';

abstract class MessagingConfiguration {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static String? _fcmToken;

  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_important_channel",
      "High Notification Important Channel",
      description: "This channel for local notifications",
      importance: Importance.max,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> configuration() async {
    // create channel
    await _createNotificationChannel();

    // Request Permission
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (Platform.isIOS) {
      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus ==
              AuthorizationStatus.provisional) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          // APNS token is available, make FCM plugin API requests...
          _fcmToken = await FirebaseMessaging.instance.getToken();
          log(_fcmToken.toString());
        }
      }
    } else {
      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus ==
              AuthorizationStatus.provisional) {
        _fcmToken = await FirebaseMessaging.instance.getToken();
        log(_fcmToken.toString());
      }
    }

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if(details.payload!=null) {
          handleNotification(
              navigationKey.currentContext!, jsonDecode(details.payload!));
        }
        return;
      },
    );

    FirebaseMessaging.onMessage.listen((event) async {
      await _flutterLocalNotificationsPlugin.show(
        event.notification.hashCode,
        event.notification!.title,
        event.notification!.body,
        payload: jsonEncode(event.data),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "high_important_channel",
            "High Notification Important Channel",
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
      //handleNotification(navigationKey.currentContext!, event.data);
    });

    // pressed on notification in foreground
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print(value);
      if (value != null) {
        print("Clicked");
        print("Clicked");
        print("Clicked");
        print("Clicked");
        print("Clicked");
        handleNotification(navigationKey.currentContext!, value.data);
      }
    });
    //pressed on background notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("send notification successfully");
      print("send notification successfully");
      print("send notification successfully");
      print("send notification successfully");
      print("send notification successfully");
      print("send notification successfully");
      print("send notification successfully");
      handleNotification(navigationKey.currentContext!, event.data);
    });
  }

  static String? getFCMToken() => _fcmToken;

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('background message ${message.notification!.body}');
  }
}
