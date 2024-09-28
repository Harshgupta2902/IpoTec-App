import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

class CoreNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> clearFCMToken() async {
    _firebaseMessaging.deleteToken();
  }

  init() async {
    await _firebaseMessaging.requestPermission();
    getToken();

    const initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_notification');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // ------- Android notification click handler
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        try {
          final Map payload = json.decode(details.payload ?? "");

          onNotificationClicked(payload: payload);
        } catch (e) {
          logger.e("onDidReceiveNotificationResponse error $e");
        }
      },
    );
  }

  fcmListener({Function()? onTap}) {
    logger.i("Notification Recieved => fcmListener  ");
    logger.i("FCM TOKEN => ${getFCMToken()}  ");

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        logger.i("Notification Recieved => fcmListener > $message ");
        logger.i("FCM TOKEN => ${getFCMToken()}  ");
        createNotification(message);
      },
    );
  }

  onNotificationClicked({required Map payload}) {
    logger.e(payload);
    if (payload.containsKey('route') && payload.containsKey('arguments')) {
      final arguments = json.decode(payload['arguments']);
      logger.i(arguments.runtimeType);
      logger.i(payload['route']);
      logger.i(arguments);

      if (arguments == null) {
        return;
      }

      MyNavigator.pushNamed(payload['route'], extra: arguments);
    } else if (payload.containsKey('route') == true) {
      MyNavigator.pushNamed(payload['route']);
    }
  }

  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map? payLoadMap = json.decode(payload ?? "");

      if (payLoadMap == null) {
        throw "error";
      }
      onNotificationClicked(payload: payLoadMap);
    } catch (e) {
      logger.e("onDidReceiveNotificationResponse error $e");
    }
  }

  static void createNotification(RemoteMessage message) async {
    try {
      final title = message.notification?.title ?? "Default Title";
      final body = message.notification?.body ?? "Default Body";
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const androidNotificationDetails = AndroidNotificationDetails(
        'pushnotification',
        'pushnotification',
        importance: Importance.max,
        priority: Priority.high,
        // styleInformation: BigPictureStyleInformation(DrawableResourceAndroidBitmap('ic_notification'), largeIcon:  DrawableResourceAndroidBitmap('ic_notification')),
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      );

      const iosNotificationDetail = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } catch (error) {
      logger.e("Notification Create Error $error");
    }
  }

  Future<void> getToken() async {
    _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    debugPrint("FCM TOKEN ::: $token");
    logger.i("----------FCM TOKEN $token----------");

    if (token == null) {
      logger.i("----------  updateFCMTokenAPI Stopped FCM Token in NULL ----------");

      return;
    }
    setFCMToken(token);
  }

  // Future<void> updateFCMToken(String? fcmToken, String? clientEndPoint) async {
  //   _firebaseMessaging.requestPermission();
  //
  //   final token = await _firebaseMessaging.getToken();
  //
  //   logger.i("----------FCM TOKEN $token----------");
  //
  //   if (token == null) {
  //     logger.i("----------  updateFCMTokenAPI Stopped FCM Token in NULL ----------");
  //
  //     return;
  //   }
  //
  //   if (clientEndPoint == null || fcmToken == null) {
  //     final response = await postRequest(
  //       apiEndPoint: ApiEndpoints.snsCreate,
  //       postData: {
  //         "fcm_token": token,
  //       },
  //     );
  //     logger.d(response);
  //     return;
  //   }
  //
  //   if (fcmToken != token) {
  //     final response = await postRequest(
  //       apiEndPoint: ApiEndpoints.snsUpdate,
  //       postData: {
  //         "fcm_token": token,
  //         "client_endpoint": clientEndPoint,
  //       },
  //     );
  //     logger.d(response);
  //     return;
  //   }
  // }
}
