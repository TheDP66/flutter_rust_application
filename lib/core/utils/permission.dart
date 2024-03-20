import 'package:InOut/core/permissions/camera.dart';
import 'package:InOut/core/permissions/external_storage.dart';
import 'package:InOut/core/permissions/notification_storage.dart';
import 'package:InOut/core/permissions/photo.dart';
import 'package:InOut/core/permissions/schedule_alarm.dart';

Future<void> checkPermissions() async {
  // Check if permissions are granted
  await photoPermission();
  await externalStoragePermission();
  await notificationPermission();
  await scheduleAlarmPermission();
  await cameraPermission();
}
