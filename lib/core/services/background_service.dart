import 'dart:async';
import 'dart:ui';

import 'package:InOut/core/channels/background_channel.dart';
import 'package:InOut/core/resources/channel.dart';
import 'package:InOut/core/resources/receive_notification.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

Future<void> backgroundService() async {
  final channel = BackgroundChannel();
  await channel.init();

  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: iosConfiguration,
    androidConfiguration: androidConfiguration(channel),
  );

  service.startService();
}

IosConfiguration iosConfiguration = IosConfiguration(
  autoStart: true,
  onForeground: onStart,
  onBackground: onIosBackground,
);

Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

AndroidConfiguration androidConfiguration(
  Channel channel,
) {
  return AndroidConfiguration(
    // this will be executed when app is in foreground or background in separated isolate
    onStart: onStart,

    // auto start service
    autoStart: true,
    autoStartOnBoot: true,
    isForegroundMode: true,

    // initial background service
    initialNotificationTitle: 'InOut',
    initialNotificationContent: 'Initializing background service...',

    // this must match with notification channel you created above.
    notificationChannelId: channel.id,
    foregroundServiceNotificationId: channel.foregroundId,
  );
}

Future<void> onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  ConnectivityResult tempConnection = ConnectivityResult.none;

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final channel = BackgroundChannel();

  // bring to foreground
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      final result = await Connectivity().checkConnectivity();

      if (await service.isForegroundService()) {
        if (result != tempConnection) {
          tempConnection = result;

          if (result != ConnectivityResult.none) {
            channel.sendNotification(
              header: "Connected to internet",
              content: "Sync offline barang now.",
            );
          } else {
            channel.sendNotification(
              header: "Disconnected from internet",
              content: "Offline mode on.",
            );
          }
        }

        // if you using custom notification, comment this
        // service.setForegroundNotificationInfo(
        //   title: "My App Service",
        //   content: "Updated at ${DateTime.now()}",
        // );
      }
    }
  });
}
