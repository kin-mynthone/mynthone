import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/onboarding_controller.dart';

part '../widgets/onboarding_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final onboardingController = OnboardingController.find;
  late Worker _onboardingStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpOnboardingStatusWorker();
  }

  @override
  void dispose() {
    _onboardingStatusWorker.dispose();
    super.dispose();
  }

  void _setUpOnboardingStatusWorker() {
    _onboardingStatusWorker = ever(
      onboardingController.status,
      (value) {
        if (value == OnboardingStatus.error) {
          Log.printInfo(onboardingController.currentState);
        }
        if (value == OnboardingStatus.finished) {
          Log.printInfo(onboardingController.currentState);
          Get.offNamed(AppPages.splash);
        }
        if (value == OnboardingStatus.loading) {
          Log.printInfo(onboardingController.currentState);
        }
        if (value == OnboardingStatus.initial) {
          Log.printInfo(onboardingController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final onboardingWidgets = [
      _OnboardingWidget(
        imagePath: AssetPath.onboarding1,
        title: 'Welcome to Secure Banking',
        description:
            'Experience the future of banking with our secure, innovative platform. Get started on your journey towards financial empowerment today.'
                .tr,
      ),
      _OnboardingWidget(
        imagePath: AssetPath.onboarding2,
        title: 'Simplified Account Setup',
        description:
            'Effortlessly set up your account in just a few easy steps. Enjoy the convenience of managing your finances with our intuitive interface.'
                .tr,
      ),
      _OnboardingWidget(
        imagePath: AssetPath.onboarding3,
        title: 'Personalized Financial Solutions',
        description:
            'Discover tailored financial solutions designed to meet your unique needs. From budgeting tools to investment options, were here to help you achieve your goals.'
                .tr,
      ),
    ];

    return PopScope(
      canPop: onboardingController.isLoading ? false : true,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.h2445D4,
            body: SafeArea(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  PageView(
                    controller: onboardingController.pageController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: onboardingWidgets,
                  ),
                  _BottomPageNavigationWidget(
                      onboardingController: onboardingController,
                      onboardingWidgets: onboardingWidgets),
                ],
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() =>
      Obx(() => LoadingOverlay(isLoading: onboardingController.isLoading));
}

class _BottomPageNavigationWidget extends StatelessWidget {
  const _BottomPageNavigationWidget({
    required this.onboardingController,
    required this.onboardingWidgets,
  });

  final OnboardingController onboardingController;
  final List<_OnboardingWidget> onboardingWidgets;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.03,
      left: 0,
      right: 0,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: onboardingController.pageController,
              count: onboardingWidgets.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColors.hE06144,
              ),
            ),
            _NextButton(),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => controller.goToNextView(),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.currentPage != 2 ? 'Next' : 'Continue',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.hF6F6F6,
                    fontSize: 15,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.arrow_forward,
            color: AppColors.hF6F6F6,
            size: 20,
          ),
        ],
      ),
    );
  }
}
