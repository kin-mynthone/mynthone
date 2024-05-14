import 'package:get_storage/get_storage.dart';

import 'log_helper.dart';

class PersistentStorage {
  static final _box = GetStorage();

  static const isDoneWithOnboarding = 'isDoneWithOnboarding';

  static const _signedInEmail = 'SignedInEmail';
  static const _signedInPassword = 'password';

  static const _accessToken = 'accessToken';

//Onboarding
  static bool getIsDoneWithOnboardingValue() {
    final value = _box.read(isDoneWithOnboarding) ?? false;
    Log.printInfo('$isDoneWithOnboarding: $value');
    return value;
  }

  static Future<void> setIsDoneWithOnboardingKey(bool value) async {
    await _box.write(isDoneWithOnboarding, value);
    Log.printInfo('$isDoneWithOnboarding: $value');
  }

//Login
  static String getSignedInEmail() {
    final value = _box.read(_signedInEmail) ?? 'no_account';
    Log.printInfo('$_signedInEmail: $value');
    return value;
  }

  static String getSignedInPassword() {
    final value = _box.read(_signedInPassword) ?? 'no_account';
    Log.printInfo('$_signedInPassword: $value');
    return value;
  }

  static Future<void> setSignedCredentials(
      {required String email, required String password}) async {
    await _box.write(_signedInEmail, email);
    await _box.write(_signedInPassword, password);

    Log.printInfo('$_signedInEmail: $email, $_signedInPassword: $password ');
  }

  static String getAccessToken() {
    final value = _box.read(_accessToken) ?? 'no_account';
    Log.printInfo('$_accessToken: $value');
    return value;
  }

  static Future<void> setAccessToken({required String accessToken}) async {
    await _box.write(_accessToken, accessToken);

    Log.printInfo('$_accessToken: $accessToken,');
  }

  static Future<void> clearLoginCredentials() async {
    await _box.remove(_signedInEmail);
    await _box.remove(_signedInPassword);
    await _box.remove(_accessToken);

    Log.printInfo('Login Credential Cleared');
  }
}
