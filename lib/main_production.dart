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
#Run app in `prd` environment
flutter run -t lib/main_production.dart  --flavor=production

# Run app in debug mode (Picks up debug signing config)
flutter run -t lib/main_production.dart  --debug --flavor=production

# Run app in release mode (Picks up release signing config)
flutter run -t lib/main_production.dart  --release --flavor=production

# Create appBundle for Android platform. Runs in release mode by default.
flutter build appbundle -t lib/main_production.dart  --flavor=production

# Create APK for production flavor. Runs in release mode by default
flutter build apk -t lib/main_production.dart  --flavor=production

# Create minified APK for production flavor.
flutter build apk -t lib/main_production.dart  --flavor=production --split-per-abi --no-shrink
*/
