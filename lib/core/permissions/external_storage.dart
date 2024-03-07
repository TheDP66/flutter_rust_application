import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> externalStoragePermission() async {
  if (Platform.isAndroid) {
    PermissionStatus extStoragePS =
        await Permission.manageExternalStorage.status;

    if (!extStoragePS.isGranted) {
      if (extStoragePS.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        extStoragePS = await Permission.manageExternalStorage.request();
      }
    }

    return await Permission.manageExternalStorage.isGranted;
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
