import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> notificationPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus notifPS = await Permission.notification.status;

    if (!notifPS.isGranted) {
      if (notifPS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        notifPS = await Permission.notification.request();
      }
    }

    return await Permission.notification.isGranted;
  } else {
    return false;
  }
}
