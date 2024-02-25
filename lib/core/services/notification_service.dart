import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

String? selectedNotificationPayload;

// this will be used as notification channel id
const notificationChannelId = "fra_channel";

// this will be used for notification id,
// So you can update your custom notification with this id.
const notificationId = 66;

Future<String?> notificationService() async {
  // ? check if notification launch app
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  log("notifiction launch app: $notificationAppLaunchDetails");

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse:
        (NotificationResponse? notificationResponse) async {
      final payload = notificationResponse?.payload;

      if (payload != null) {
        log('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    },
  );

  return selectedNotificationPayload;
}
