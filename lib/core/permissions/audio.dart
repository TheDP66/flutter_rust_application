import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> audioPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus audioPS = await Permission.audio.status;

    if (!audioPS.isGranted) {
      if (audioPS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        audioPS = await Permission.audio.request();
      }
    }

    return await Permission.audio.isGranted;
  } else {
    PermissionStatus storagePS = await Permission.storage.request();

    if (!storagePS.isGranted) {
      if (storagePS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        storagePS = await Permission.storage.request();
      }
    }

    return false;
  }
}
