import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';

class CoreNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> updateFCMToken() async {
    _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    logger.i("----------FCM TOKEN $fcmToken----------");

    if (fcmToken == null) {
      logger.i("----------  updateFCMTokenAPI Stopped FCM Token in NULL ----------");
      return;
    }

    final prefsFCM = getFCMToken();

    if (prefsFCM == null) {
      setFCMToken(fcmToken);
    } else if (prefsFCM == fcmToken) {
      logger.d("----------  updateFCMTokenAPI Stopped Same FCM Token ----------");
      return;
    }
  }

  Future<void> clearFCMToken() async {
    _firebaseMessaging.deleteToken();
    // _defaultDataController.updateFCMToken(token: null);
  }

  init() async {
    await _firebaseMessaging.requestPermission();

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
          logger.d("Notification clicked ${details.payload}");
          final Map payload = json.decode(details.payload ?? "");
          onNotificationClicked(payload: payload);
        } catch (e) {
          logger.e("onDidReceiveNotificationResponse error $e");
        }
      },
    );
  }

  fcmListener() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        logger.i("notification recieved");
        // _coreNotificationController.getNotificationData();
        createNotification(message);
      },
    );
  }

  onNotificationClicked({required Map payload}) {
    // TODO :: HANDLE N
  }

  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map payLoadMap = json.decode(payload ?? "");

      onNotificationClicked(payload: payLoadMap);
    } catch (e) {
      logger.e("onDidReceiveNotificationResponse error $e");
    }
  }

  static void createNotification(RemoteMessage message) async {
    try {
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
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } catch (error) {
      logger.e("Notification Create Error $error");
    }
  }
}
