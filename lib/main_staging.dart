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
          flavor: 'Staging',
        ),
      );
    },
    (error, stack) {},
  );
}

/*
#Run app in `stg` environment
flutter run -t lib/main_staging.dart  --flavor=staging

# Run app in debug mode (Picks up debug signing config)
flutter run -t lib/main_staging.dart  --debug --flavor=staging

# Run app in release mode (Picks up release signing config)
flutter run -t lib/main_staging.dart  --release --flavor=staging

# Create appBundle for Android platform. Runs in release mode by default.
flutter build appbundle -t lib/main_staging.dart  --flavor=staging

# Create APK for staging flavor. Runs in release mode by default
* flutter build apk -t lib/main_staging.dart  --flavor=staging

# Create minified APK for staging flavor.
flutter build apk -t lib/main_staging.dart  --flavor=staging --split-per-abi --no-shrink
*/
