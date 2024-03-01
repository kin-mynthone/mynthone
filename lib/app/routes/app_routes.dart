part of 'app_pages.dart';

abstract class _Routes {
  _Routes._();
  static const introduction = _Paths.introduction;
  static const splash = _Paths.splash;
  static const onboarding = _Paths.onboarding;
}

abstract class _Paths {
  _Paths._();
  static const introduction = '/introduction';
  static const splash = '/splash';
  static const onboarding = '/onboarding';
}
