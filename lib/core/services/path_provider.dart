import 'dart:io';

import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

Future<void> registerPathProvider() async {
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();
}
