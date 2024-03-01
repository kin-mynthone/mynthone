import 'package:get_storage/get_storage.dart';

import 'log_helper.dart';

class PersistentStorage {
  static final _box = GetStorage();

  static const isDoneWithOnboarding = 'isDoneWithOnboarding';

  static bool getIsDoneWithOnboardingValue() {
    final value = _box.read(isDoneWithOnboarding) ?? false;
    Log.printInfo('$isDoneWithOnboarding: $value');
    return value;
  }

  static Future<void> setIsDoneWithOnboardingKey(bool value) async {
    await _box.write(isDoneWithOnboarding, value);
    Log.printInfo('$isDoneWithOnboarding: $value');
  }
}
