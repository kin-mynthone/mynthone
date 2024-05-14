import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/enums/flavor_enum.dart';
import 'app/helpers/env_helper.dart';
import 'app/helpers/log_helper.dart';
import 'app/helpers/persistent_storage_helper.dart';
import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _logAppInfo();
  await _loadEnv();
  // await _initializeSupabase();
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
    await dotenv.load(fileName: Env.productionEnvFile);
    Log.printInfo('Loaded ${Env.productionEnvFile} successfully.');
  } catch (_) {
    Log.printError('Unable to load ${Env.productionEnvFile}.');
  }
}

String _getFlavor() {
  try {
    final flavor = Flavor.production.description;
    return flavor;
  } catch (_) {
    Log.printError('Unable to get flavor/environment.');
    return '';
  }
}

Future<void> _initializeSupabase() async {
  try {
    final supabaseApp = await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnon,
    );
    Log.printInfo('Supabase App has been initialized. $supabaseApp');
  } catch (_) {
    Log.printError('Unable to initialize Supabase');
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
#Run app in production environment
fvm flutter run -t lib/main_production.dart  --flavor=production

# Run app in debug mode (Picks up debug signing config)
fvm flutter run -t lib/main_production.dart  --debug --flavor=production

# Run app in release mode (Picks up release signing config)
fvm flutter run -t lib/main_production.dart  --release --flavor=production

# Create appBundle for Android platform. Runs in release mode by default.
fvm flutter build appbundle -t lib/main_production.dart  --flavor=production

# Create APK for production flavor. Runs in release mode by default
fvm flutter build apk -t lib/main_production.dart  --flavor=production

# Create a build for IOS
fvm flutter build ios -t lib/main_production.dart --flavor production
*/