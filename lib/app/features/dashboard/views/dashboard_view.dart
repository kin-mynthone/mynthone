import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../helpers/asset_path_helper.dart';
import '../../../models/account_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../controllers/dashboard_controller.dart';

part '../widgets/body_widget.dart';
part '../widgets/bottom_navigation_bar_widget.dart';

class DashboardViewArgs {
  final Account account;

  DashboardViewArgs({
    required this.account,
  });
}

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: controller.innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: AppColors.h425AC2,
      colorTransitionScaffold: Colors.transparent,
      offset: const IDOffset.only(bottom: 0.0, right: 0.0, left: 0.7),
      scale: const IDOffset.horizontal(0.8),
      proportionalChildArea: true,
      borderRadius: 30,
      leftAnimationType: InnerDrawerAnimation.static,
      backgroundDecoration: const BoxDecoration(color: AppColors.h425AC2),
      leftChild: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 130),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: const [
              _DrawerHeaderWidget(),
              SizedBox(
                height: 50,
              ),
              _GotoAccounts(),
              _GotoBeneficiary(),
              _GotoGenerateQrCode(),
              _GotoLimits(),
              _GotoProfileSettings(),
            ],
          ),
        ),
      ),
      scaffold: const Scaffold(
        body: _BodyWidget(),
        bottomNavigationBar: _BottomNavigationBarWidget(),
      ),
    );
  }
}

class _GotoAccounts extends StatelessWidget {
  const _GotoAccounts();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: 'Your Account'.tr,
        color: AppColors.hF6F6F6,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(
        AssetPath.accounts,
        colorFilter: const ColorFilter.mode(
          AppColors.hF6F6F6,
          BlendMode.modulate, // Blend mode
        ),
        height: 25,
      ),
      onTap: () {
        // Handle option 1
      },
    );
  }
}

class _GotoBeneficiary extends StatelessWidget {
  const _GotoBeneficiary();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: 'Beneficiaries'.tr,
        color: AppColors.hF6F6F6,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(
        AssetPath.beneficiary,
        colorFilter: const ColorFilter.mode(
          AppColors.hF6F6F6,
          BlendMode.modulate, // Blend mode
        ),
        height: 25,
      ),
      onTap: () {
        // Handle option 1
      },
    );
  }
}

class _GotoGenerateQrCode extends StatelessWidget {
  const _GotoGenerateQrCode();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: 'Generate QR code'.tr,
        color: AppColors.hF6F6F6,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(
        AssetPath.qrScanner,
        colorFilter: const ColorFilter.mode(
          AppColors.hF6F6F6,
          BlendMode.modulate, // Blend mode
        ),
        height: 25,
      ),
      onTap: () {
        // Handle option 1
      },
    );
  }
}

class _GotoLimits extends StatelessWidget {
  const _GotoLimits();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: 'Limits'.tr,
        color: AppColors.hF6F6F6,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(
        AssetPath.limits,
        colorFilter: const ColorFilter.mode(
          AppColors.hF6F6F6,
          BlendMode.modulate, // Blend mode
        ),
        height: 25,
      ),
      onTap: () {
        // Handle option 1
      },
    );
  }
}

class _GotoProfileSettings extends StatelessWidget {
  const _GotoProfileSettings();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: 'Profile Settings'.tr,
        color: AppColors.hF6F6F6,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(
        AssetPath.profileSettings,
        colorFilter: const ColorFilter.mode(
          AppColors.hF6F6F6,
          BlendMode.modulate, // Blend mode
        ),
        height: 25,
      ),
      onTap: () {
        // Handle option 1
      },
    );
  }
}

class _DrawerHeaderWidget extends StatelessWidget {
  const _DrawerHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: const NetworkImage(
            'https://via.placeholder.com/50', // Sample image URL
          ),
          backgroundColor:
              Colors.transparent, // Make the background transparent
          // Add a white border
          foregroundColor: Colors.white, // Set the border color
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomTextWidget(
          text: 'Kindred Inocencio',
          color: AppColors.hF6F6F6,
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
        const SizedBox(
          height: 5,
        ),
        const _FullyVerifiedWidget(),
      ],
    );
  }
}

class _FullyVerifiedWidget extends StatelessWidget {
  const _FullyVerifiedWidget();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.hF87054,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPath.verified,
              colorFilter: const ColorFilter.mode(
                AppColors.hF6F6F6,
                BlendMode.modulate,
              ),
              height: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            const CustomTextWidget(
              text: 'Fully Verified',
              color: AppColors.hF6F6F6,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
