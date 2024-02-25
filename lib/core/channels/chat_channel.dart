import 'dart:typed_data';

import 'package:InOut/core/resources/channel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChatChannel implements Channel {
  @override
  String get id => "fra_chat_channel";

  @override
  int get foregroundId => 1;

  @override
  String get title => "Chat channel";

  @override
  String get description => 'This channel is used to inform chat.';

  Future<void> init() async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      id, // id
      title, // title
      description: description, // description
      importance: Importance.low, // importance must be at low or higher level
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );

    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> sendNotification({
    String? header,
    String? content,
    String? payload,
  }) async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    AndroidNotificationDetails notifDetail = AndroidNotificationDetails(
      id, // id
      title, // title
      channelDescription: description, // description
      importance: Importance.high, // importance must be at low or high level

      enableVibration: true,
      vibrationPattern: vibrationPattern,

      channelShowBadge: true,
      fullScreenIntent: true,
      icon: "@mipmap/ic_launcher",
      ticker: "ticker",
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: notifDetail,
    );

    await FlutterLocalNotificationsPlugin().show(
      0,
      header,
      content,
      platformChannelSpecifics,
      payload: 'item 2',
    );
  }
}
