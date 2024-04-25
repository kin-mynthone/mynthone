import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/enums/flavor_enum.dart';
import 'app/helpers/env_helper.dart';
import 'app/helpers/log_helper.dart';
import 'app/helpers/persistent_storage_helper.dart';
import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _logAppInfo();
  await _loadEnv();
  await _initializeFirebase();
  String flavor = _getFlavor();
  await _initializePersistentStorage();
  runApp(
    MainApp(
      flavor: flavor,
      isDoneWithOnboarding: PersistentStorage.getIsDoneWithOnboardingValue(),
    ),
  );
}

Future<void> _logAppInfo() async {
  if (kDebugMode) {
    try {
      final info = await PackageInfo.fromPlatform();

      final os = 'App OS: ${Platform.operatingSystem.toUpperCase()}';
      final appName = 'App Name: ${info.appName}';
      final appPackageName = 'Package Name: ${info.packageName}';
      final appVersionNumber = 'Version: ${info.version}+${info.buildNumber}';
      Log.printInfo('$os | $appName | $appPackageName | $appVersionNumber');
    } catch (_) {
      Log.printError('Unable to get package info.');
    }
  }
}

Future<void> _loadEnv() async {
  try {
    await dotenv.load(fileName: Env.developmentEnvFile);
    Log.printInfo('Loaded ${Env.developmentEnvFile} successfully.');
  } catch (_) {
    Log.printError('Unable to load ${Env.developmentEnvFile}.');
  }
}

String _getFlavor() {
  try {
    final flavor = Flavor.development.description;
    return flavor;
  } catch (_) {
    Log.printError('Unable to get flavor/environment.');
    return '';
  }
}

//todo remove this
Future<void> _initializeFirebase() async {
  try {
    final firebaseApp = await Firebase.initializeApp();
    Log.printInfo('Firebase App has been initialized. $firebaseApp');
  } catch (_) {
    Log.printError('Unable to initialize firebase');
  }
}

Future<void> _initializePersistentStorage() async {
  try {
    await GetStorage.init();
    Log.printInfo('Persistent storage has been initialized.');
  } catch (_) {
    Log.printError('Unable to initialize persistent storage');
  }
}

/*
#Run app in development environment
fvm flutter run -t lib/main_development.dart  --flavor=development

# Run app in debug mode (Picks up debug signing config)
fvm flutter run -t lib/main_development.dart  --debug --flavor=development
*/
