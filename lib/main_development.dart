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
          flavor: 'Development',
        ),
      );
    },
    (error, stack) {},
  );
}



/*
#Run app in development environment
fvm flutter run -t lib/main_development.dart  --flavor=development

# Run app in debug mode (Picks up debug signing config)
fvm flutter run -t lib/main_development.dart  --debug --flavor=development
*/
