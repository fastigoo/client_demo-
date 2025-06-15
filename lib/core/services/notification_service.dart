import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:client/core/services/storage_manager.dart';
import 'package:client/routes/app_pages.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final NotificationService notificationService = NotificationService();
  await notificationService._showLocalNotification(message);
  Get.to(Routes.INITIAL);
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken() ?? '';
    StorageManager.instance.saveFcmToken(token: token);
    initPushNotification();
  }

  void handleMessage(RemoteMessage? msg) {
    if (msg != null) {
      Get.to(Routes.INITIAL);
    }
  }

  Future initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'order_channel_id',
      'order_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails darwinPlatformChannelSpecifics = DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title, // Title
      message.notification?.body, // Body
      platformChannelSpecifics,
    );
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
