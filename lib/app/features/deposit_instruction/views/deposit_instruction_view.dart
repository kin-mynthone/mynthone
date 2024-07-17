import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/deposit_instruction_controller.dart';

part '../widgets/onboarding_widget.dart';

class DepositInstructionView extends StatefulWidget {
  const DepositInstructionView({super.key});

  @override
  State<DepositInstructionView> createState() => _DepositInstructionViewState();
}

class _DepositInstructionViewState extends State<DepositInstructionView> {
  final depositInstructionController = DepositInstructionController.find;
  late Worker _depositInstructionStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpDepositInstructionStatusWorker();
  }

  @override
  void dispose() {
    _depositInstructionStatusWorker.dispose();
    super.dispose();
  }

  void _setUpDepositInstructionStatusWorker() {
    _depositInstructionStatusWorker = ever(
      depositInstructionController.status,
      (value) {
        if (value == DepositInstructionStatus.error) {
          Log.printInfo(depositInstructionController.currentState);
        }
        if (value == DepositInstructionStatus.finished) {
          Log.printInfo(depositInstructionController.currentState);
          Get.offNamed(AppPages.splash);
        }
        if (value == DepositInstructionStatus.loading) {
          Log.printInfo(depositInstructionController.currentState);
        }
        if (value == DepositInstructionStatus.initial) {
          Log.printInfo(depositInstructionController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final depositInstructionWidgets = [
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding1,
        title: 'Choose Your Deposit Method',
        description:
            'Select your preferred deposit method. Common options include bank transfer, credit/debit card, or direct deposit from another account. Each method might have different processing times and fees.'
                .tr,
      ),
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding2,
        title: 'Enter Deposit Amount',
        description:
            ' Input the amount you wish to deposit. Double-check the amount to ensure accuracy. Some platforms might display the minimum and maximum deposit limits.'
                .tr,
      ),
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding3,
        title: 'Provide Necessary Details',
        description:
            'Depending on the deposit method chosen, you might need to enter additional details such as bank account number, card details, or other relevant information. Ensure all details are correct to avoid transaction failures.'
                .tr,
      ),
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding3,
        title: 'Review and Confirm',
        description:
            'Review all the information you’ve entered, including the deposit amount and method. Confirm that everything is correct before proceeding. Some platforms may provide a summary page for you to review.'
                .tr,
      ),
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding3,
        title: 'Complete the Deposit',
        description:
            'Click on the "Submit" or "Confirm" button to complete the deposit. You might be asked to enter a security code or complete an additional verification step for security purposes.'
                .tr,
      ),
      _DepositInstructionWidget(
        imagePath: AssetPath.onboarding3,
        title: 'Receive Confirmation',
        description:
            'After the deposit is processed, you should receive a confirmation message or email. Check your account balance to ensure the deposit was successful.'
                .tr,
      ),
    ];

    return PopScope(
      canPop: depositInstructionController.isLoading ? false : true,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.h2445D4,
            body: SafeArea(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  PageView(
                    controller: depositInstructionController.pageController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: depositInstructionWidgets,
                  ),
                  _BottomPageNavigationWidget(
                      depositInstructionController:
                          depositInstructionController,
                      depositInstructionWidgets: depositInstructionWidgets),
                ],
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() => Obx(
      () => LoadingOverlay(isLoading: depositInstructionController.isLoading));
}

class _BottomPageNavigationWidget extends StatelessWidget {
  const _BottomPageNavigationWidget({
    required this.depositInstructionController,
    required this.depositInstructionWidgets,
  });

  final DepositInstructionController depositInstructionController;
  final List<_DepositInstructionWidget> depositInstructionWidgets;

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
              controller: depositInstructionController.pageController,
              count: depositInstructionWidgets.length,
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

class _NextButton extends GetView<DepositInstructionController> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => controller.goToNextView(),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.currentPage != 5 ? 'Next' : 'Continue',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.hF6F6F6,
                    fontSize: 15,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 5),
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
