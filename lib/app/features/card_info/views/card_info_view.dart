import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/debit_card_model.dart';
import '../../../models/statement_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/card_info_controller.dart';

part '../widget/statement_widget.dart';
part '../widget/card_flip_widget.dart';
part '../widget/block_this_card_widget.dart';

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
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AssetPath.edit,
                      height: 25,
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppNumbers.screenPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeaderTitleWidget(),
                        SizedBox(height: 20),
                        _CardFlipWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => controller.isBackCardShown
                        ? const _BlockThisCardWidget()
                        : const _StatementWidget(),
                  )
                ],
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
        Text(
          cardInfoViewArgs.debitCard.cardName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h2445D4,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          'Euro Account',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.h403E51,
              ),
        ),
      ],
    );
  }
}
