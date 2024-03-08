import 'package:get/get.dart';

import '../features/auth_otp/bindings/auth_otp_binding.dart';
import '../features/auth_otp/views/auth_otp_view.dart';
import '../features/dashboard/bindings/dashboard_binding.dart';
import '../features/dashboard/views/dashboard_view.dart';
import '../features/home/bindings/home_binding.dart';
import '../features/home/views/home_view.dart';
import '../features/introduction/bindings/introduction_binding.dart';
import '../features/introduction/views/introduction_view.dart';
import '../features/onboarding/bindings/onboarding_binding.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/select_account/bindings/select_account_binding.dart';
import '../features/select_account/views/select_account_view.dart';
import '../features/sign_in/bindings/sign_in_binding.dart';
import '../features/sign_in/views/sign_in_view.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const introduction = _Routes.introduction;
  static const splash = _Routes.splash;
  static const onboarding = _Routes.onboarding;
  static const signIn = _Routes.signIn;
  static const authOtp = _Routes.authOtp;
  static const selectAccount = _Routes.selectAccount;
  static const dashboard = _Routes.dashboard;
  static const home = _Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.introduction,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.authOtp,
      page: () => const AuthOtpView(),
      binding: AuthOtpBinding(),
    ),
    GetPage(
      name: _Paths.selectAccount,
      page: () => const SelectAccountView(),
      binding: SelectAccountBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
