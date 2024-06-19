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
  static const statement = _Paths.statement;
  static const cardList = _Paths.cardList;
  static const cardInfo = _Paths.cardInfo;
  static const beneficiary = _Paths.beneficiary;
  static const statementInfo = _Paths.statementInfo;
  static const transferFund = _Paths.transferFund;
  static const transferConfirmation = _Paths.transferConfirmation;
  static const transferSummary = _Paths.transferSummary;
  static const otherModules = _Paths.otherModules;
  static const merchants = _Paths.merchants;
  static const bngHome = _Paths.bngHome;
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
  static const statement = '/statement';
  static const cardList = '/card-list';
  static const cardInfo = '/card-info';
  static const beneficiary = '/beneficiary';
  static const statementInfo = '/statement-info';
  static const transferFund = '/transfer-fund';
  static const transferConfirmation = '/transfer-confirmation';
  static const transferSummary = '/transfer-summary';
  static const otherModules = '/other-modules';
  static const merchants = '/merchants';
  static const bngHome = '/bng-home';
}
