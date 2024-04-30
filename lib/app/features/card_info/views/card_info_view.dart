import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/debit_card_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/card_info_controller.dart';

class CardInfoViewArgs {
  final DebitCard debitCard;

  CardInfoViewArgs({
    required this.debitCard,
  });
}

class CardInfoView extends GetView<CardInfoController> {
  const CardInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: CardInfoController.find.isLoading ? false : true,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: GoBackButton(
                onPressed: () => Get.back(closeOverlays: true),
                iconColor: AppColors.h403E51,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AssetPath.edit,
                    height: 28,
                  ),
                )
              ],
            ),
            body: const SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppNumbers.screenPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderTitleWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      CardFlipWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() {
    return Obx(
        () => LoadingOverlay(isLoading: CardInfoController.find.isLoading));
  }
}

class _HeaderTitleWidget extends StatelessWidget {
  const _HeaderTitleWidget();

  @override
  Widget build(BuildContext context) {
    final cardInfoViewArgs = Get.arguments as CardInfoViewArgs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: cardInfoViewArgs.debitCard.cardName,
          color: AppColors.h425AC2,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 5,
        ),
        const CustomTextWidget(
          text: 'Euro Account',
          color: AppColors.h403E51,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

class CardFlipWidget extends GetView<CardInfoController> {
  const CardFlipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: controller.cardKey,
      flipOnTouch: false,
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: _FrontCardWidget(),
      back: _BackCardWidget(),
    );
  }
}

class _FrontCardWidget extends GetView<CardInfoController> {
  @override
  Widget build(BuildContext context) {
    final cardInfoViewArgs = Get.arguments as CardInfoViewArgs;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.h425AC2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AssetPath.visa,
            colorFilter: const ColorFilter.mode(
              AppColors.hF6F6F6,
              BlendMode.modulate,
            ),
            height: 15,
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: cardInfoViewArgs.debitCard.cardName,
                color: AppColors.hF6F6F6,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextWidget(
                text:
                    '${cardInfoViewArgs.debitCard.currency} ${cardInfoViewArgs.debitCard.amount}',
                color: AppColors.hF6F6F6,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => {
                controller.cardKey.currentState?.toggleCard(),
                controller.setIsBackCardShown(true)
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  AssetPath.turn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackCardWidget extends GetView<CardInfoController> {
  @override
  Widget build(BuildContext context) {
    final cardInfoViewArgs = Get.arguments as CardInfoViewArgs;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.h425AC2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Acct. no:'.tr,
                color: AppColors.hF6F6F6,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              CustomTextWidget(
                text: cardInfoViewArgs.debitCard.accountNumber,
                color: AppColors.hF6F6F6,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomTextWidget(
                    text: 'Valid Thu:'.tr,
                    color: AppColors.hF6F6F6,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomTextWidget(
                    text: cardInfoViewArgs.debitCard.validity,
                    color: AppColors.hF6F6F6,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ],
              ),
              Obx(() => Row(
                    children: [
                      CustomTextWidget(
                        text: 'CVV:'.tr,
                        color: AppColors.hF6F6F6,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.hF87054,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CardInfoController.find.obscuredCvv
                                ? const CustomTextWidget(
                                    text: '•••',
                                    color: AppColors.hF6F6F6,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  )
                                : CustomTextWidget(
                                    text: cardInfoViewArgs.debitCard.cvv,
                                    color: AppColors.hF6F6F6,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => controller.toggleObscuredCvv(),
                              child: controller.obscuredCvv
                                  ? SvgPicture.asset(
                                      AssetPath.eye,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.hF6F6F6,
                                        BlendMode.srcIn,
                                      ),
                                      height: 20,
                                    )
                                  : SvgPicture.asset(
                                      AssetPath.eyeSlash,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.hF6F6F6,
                                        BlendMode.srcIn,
                                      ),
                                      height: 20,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => {
                controller.cardKey.currentState?.toggleCard(),
                controller.setIsBackCardShown(false)
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  AssetPath.turn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
