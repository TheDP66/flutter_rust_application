import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> cameraPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus cameraPS = await Permission.camera.status;

    if (!cameraPS.isGranted) {
      if (cameraPS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        cameraPS = await Permission.camera.request();
      }
    }

    return await Permission.camera.isGranted;
  } else {
    return false;
  }
}
