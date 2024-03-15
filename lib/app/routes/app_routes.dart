part of 'app_pages.dart';

abstract class _Routes {
  _Routes._();
  static const introduction = _Paths.introduction;
  static const splash = _Paths.splash;
  static const onboarding = _Paths.onboarding;
  static const signIn = _Paths.signIn;
  static const authOtp = _Paths.authOtp;
  static const selectAccount = _Paths.selectAccount;
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
  static const cardList = _Paths.cardList;
}

abstract class _Paths {
  _Paths._();
  static const introduction = '/introduction';
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const authOtp = '/auth-otp';
  static const selectAccount = '/select-account';
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const cardList = '/card-list';
}
