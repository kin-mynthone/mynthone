import 'package:get/get.dart';
import 'package:mynthone/app/features/beam_and_go/select_beneficiary/bindings/select_beneficiary_binding.dart';
import 'package:mynthone/app/features/beam_and_go/select_beneficiary/views/select_beneficiary_view.dart';

import '../features/auth_otp/bindings/auth_otp_binding.dart';
import '../features/auth_otp/views/auth_otp_view.dart';
import '../features/beam_and_go/merchants/bindings/merchants_binding.dart';
import '../features/beam_and_go/merchants/views/merchants_view.dart';
import '../features/beneficiary/bindings/beneficiary_binding.dart';
import '../features/beneficiary/views/beneficiary_view.dart';
import '../features/card_info/bindings/card_info_binding.dart';
import '../features/card_info/views/card_info_view.dart';
import '../features/dashboard/bindings/dashboard_binding.dart';
import '../features/dashboard/views/dashboard_view.dart';
import '../features/dashboard_card/bindings/card_binding.dart';
import '../features/dashboard_card/views/card_view.dart';
import '../features/dashboard_home/bindings/home_binding.dart';
import '../features/dashboard_home/views/home_view.dart';
import '../features/dashboard_statements/bindings/statements_binding.dart';
import '../features/dashboard_statements/views/statements_view.dart';
import '../features/introduction/bindings/introduction_binding.dart';
import '../features/introduction/views/introduction_view.dart';
import '../features/onboarding/bindings/onboarding_binding.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/other_modules/bindings/other_modules_binding.dart';
import '../features/other_modules/views/other_modules_view.dart';
import '../features/select_account/bindings/select_account_binding.dart';
import '../features/select_account/views/select_account_view.dart';
import '../features/sign_in/bindings/sign_in_binding.dart';
import '../features/sign_in/views/sign_in_view.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/splash/views/splash_view.dart';
import '../features/statement_info/views/statement_info_view.dart';
import '../features/transfer_confirmation/bindings/transfer_confirmation_binding.dart';
import '../features/transfer_confirmation/views/transfer_confirmation_view.dart';
import '../features/transfer_fund/bindings/transfer_fund_binding.dart';
import '../features/transfer_fund/views/transfer_fund_view.dart';
import '../features/transfer_summary/bindings/transfer_summary_binding.dart';
import '../features/transfer_summary/views/transfer_summary_view.dart';

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
  static const cardList = _Routes.cardList;
  static const statement = _Routes.statement;
  static const cardInfo = _Routes.cardInfo;
  static const beneficiary = _Routes.beneficiary;
  static const statementInfo = _Routes.statementInfo;
  static const transferFund = _Routes.transferFund;
  static const transferConfirmation = _Routes.transferConfirmation;
  static const transferSummary = _Routes.transferSummary;
  static const otherModules = _Routes.otherModules;
  static const merchants = _Routes.merchants;
  static const selectBeneficiary = _Routes.selectBeneficiary;

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
    GetPage(
      name: _Paths.cardList,
      page: () => const CardView(),
      binding: CardBinding(),
    ),
    GetPage(
      name: _Paths.statement,
      page: () => const StatementView(),
      binding: StatementBinding(),
    ),
    GetPage(
      name: _Paths.cardInfo,
      page: () => const CardInfoView(),
      binding: CardInfoBinding(),
    ),
    GetPage(
      name: _Paths.beneficiary,
      page: () => const BeneficiaryView(),
      binding: BeneficiaryBinding(),
    ),
    GetPage(
        name: _Paths.statementInfo,
        page: () => const StatementInfoView(),
        binding: StatementBinding()),
    GetPage(
        name: _Paths.transferFund,
        page: () => const TransferFundView(),
        binding: TransferFundBinding()),
    GetPage(
        name: _Paths.transferConfirmation,
        page: () => const TransferConfirmationView(),
        binding: TransferConfirmationBinding()),
    GetPage(
        name: _Paths.transferSummary,
        page: () => const TransferSummaryView(),
        binding: TransferSummaryBinding()),
    GetPage(
        name: _Paths.otherModules,
        page: () => const OtherModulesView(),
        binding: OtherModulesBinding()),
    GetPage(
        name: _Paths.merchants,
        page: () => const MerchantsView(),
        binding: MerchantsBinding()),
    GetPage(
        name: _Paths.selectBeneficiary,
        page: () => const SelectBeneficiaryView(),
        binding: SelectBeneficiaryBinding()),
  ];
}
