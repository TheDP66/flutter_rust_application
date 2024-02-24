import 'dart:io';

import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermissions() async {
  // Check if permissions are granted
  if (Platform.isAndroid) {
    await Permission.audio.request();

    PermissionStatus extStoragePS =
        await Permission.manageExternalStorage.status;
    if (!extStoragePS.isGranted) {
      extStoragePS = await Permission.manageExternalStorage.request();
    } else if (extStoragePS.isDenied || extStoragePS.isPermanentlyDenied) {
      openAppSettings();
    }

    PermissionStatus photoPS = await Permission.photos.status;
    if (!photoPS.isGranted) {
      photoPS = await Permission.photos.request();
    } else if (photoPS.isDenied || photoPS.isPermanentlyDenied) {
      openAppSettings();
    }

    PermissionStatus notifPS = await Permission.notification.status;
    if (!notifPS.isGranted) {
      notifPS = await Permission.notification.request();
    } else if (notifPS.isDenied || notifPS.isPermanentlyDenied) {
      openAppSettings();
    }

    PermissionStatus scheduleAlarmPS =
        await Permission.scheduleExactAlarm.status;
    if (!scheduleAlarmPS.isGranted) {
      scheduleAlarmPS = await Permission.scheduleExactAlarm.request();
    } else if (scheduleAlarmPS.isDenied ||
        scheduleAlarmPS.isPermanentlyDenied) {
      openAppSettings();
    }
  } else {
    PermissionStatus storagePS = await Permission.storage.request();
    if (!storagePS.isGranted) {
      storagePS = await Permission.storage.request();
    } else if (storagePS.isDenied || storagePS.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();
}
