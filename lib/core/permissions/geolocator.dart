import 'package:geolocator/geolocator.dart';

Future<bool> geolocatorService() async {
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
  }

  return await Geolocator.isLocationServiceEnabled();
}

Future<bool> geolocatorPermission() async {
  LocationPermission geoPS = await Geolocator.checkPermission();

  if (geoPS == LocationPermission.denied) {
    geoPS = await Geolocator.requestPermission();

    if (geoPS == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }
  }

  if (geoPS == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
  }

  geoPS = await Geolocator.checkPermission();

  return geoPS == LocationPermission.whileInUse ||
      geoPS == LocationPermission.always;
}
