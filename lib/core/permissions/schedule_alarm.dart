import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> scheduleAlarmPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus scheduleAlarmPS =
        await Permission.scheduleExactAlarm.status;

    if (!scheduleAlarmPS.isGranted) {
      if (scheduleAlarmPS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        scheduleAlarmPS = await Permission.scheduleExactAlarm.request();
      }
    }

    return await Permission.scheduleExactAlarm.isGranted;
  } else {
    return false;
  }
}
