import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/localization/app_translations.dart';
import 'app/routes/app_pages.dart';
import 'app/themes/app_themes.dart';

class MainApp extends StatelessWidget {
  final String flavor;
  final bool isDoneWithOnboarding;

  const MainApp({
    super.key,
    required this.flavor,
    required this.isDoneWithOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    switch (flavor) {
      case "PRODUCTION":
        return showAppForReleasing();
      case "STAGING":
        return showAppForReleasing();
      case "DEVELOPMENT":
        return showAppForDebugging();
      default:
        return showAppForReleasing();
    }
    // return showAppForReleasing();
  }

  DevicePreview showAppForDebugging() {
    return DevicePreview(
      enabled: false,
      builder: (context) => GetMaterialApp(
        title: '$flavor Mynthone',
        defaultTransition: _defaultTransition,
        initialRoute: _getInitialRoute(),
        getPages: AppPages.routes,
        builder: (context, child) {
          child = ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: _breakpoints,
          );
          child = DevicePreview.appBuilder(context, child);
          return child;
        },
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        theme: AppThemes.lightTheme,
        fallbackLocale: const Locale('en', 'US'),
        translations: AppTranslations(),
      ),
    );
  }

  GetMaterialApp showAppForReleasing() {
    return GetMaterialApp(
      title: '$flavor Mynthone',
      defaultTransition: _defaultTransition,
      initialRoute: _getInitialRoute(),
      getPages: AppPages.routes,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: _breakpoints,
      ),
      theme: AppThemes.lightTheme,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
    );
  }

  static final List<Breakpoint> _breakpoints = [
    const Breakpoint(start: 0, end: 360, name: 'SMALL'),
    const Breakpoint(start: 361, end: 480, name: 'MEDIUM'),
    const Breakpoint(start: 481, end: 640, name: 'LARGE'),
    const Breakpoint(start: 641, end: 1080, name: 'LARGER'),
    const Breakpoint(start: 1081, end: double.infinity, name: 'OTHER'),
  ];

  static const _defaultTransition = Transition.rightToLeft;

  String _getInitialRoute() =>
      isDoneWithOnboarding ? AppPages.splash : AppPages.introduction;
}
