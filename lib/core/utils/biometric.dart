import 'package:local_auth/local_auth.dart';

Future<bool> getBiometricPermission(String localizedReason) async {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final bool canAuthenticateWithBiometrics =
      await _localAuthentication.canCheckBiometrics;
  final bool canAuthenticate = canAuthenticateWithBiometrics ||
      await _localAuthentication.isDeviceSupported();

  if (canAuthenticate) {
    final bool didAuthenticate = await _localAuthentication.authenticate(
      localizedReason: 'Please authenticate to login',
      options: const AuthenticationOptions(
        useErrorDialogs: false,
        stickyAuth: true,
        sensitiveTransaction: true,
      ),
    );

    return didAuthenticate;
  } else {
    throw Exception(
        "Biometric authentication is not available on this device.");
  }
}
