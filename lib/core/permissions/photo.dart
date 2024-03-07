import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> photoPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus photoPS = await Permission.photos.status;

    if (!photoPS.isGranted) {
      if (photoPS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        photoPS = await Permission.photos.request();
      }
    }

    return await Permission.photos.isGranted;
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
