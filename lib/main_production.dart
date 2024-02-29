import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_app.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final orientations = [DeviceOrientation.portraitUp];
      await SystemChrome.setPreferredOrientations(orientations);

      runApp(
        const MainApp(
          flavor: 'production',
        ),
      );
    },
    (error, stack) {},
  );
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