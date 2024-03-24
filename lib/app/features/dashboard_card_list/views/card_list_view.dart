import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/card_info/views/card_info_view.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/debit_card_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../controllers/card_list_controller.dart';

class CardListView extends GetView<CardListController> {
  const CardListView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_HeaderWidget(), _DebitCardsListView()],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      color: AppColors.hF2F4FE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Your Cards'.tr,
                color: AppColors.h425AC2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextWidget(
                text: 'Total Cards:'.tr,
                color: AppColors.h8E8E8E,
                fontSize: 15,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_outlined,
              color: AppColors.h403E51,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class _DebitCardsListView extends GetView<CardListController> {
  const _DebitCardsListView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.separated(
          itemCount: controller.debitCards.length,
          padding: const EdgeInsets.all(AppNumbers.screenPadding),
          itemBuilder: (context, index) {
            final debitCard = controller.debitCards[index];
            return _DebitCardListTileWidget(
              debitCard: debitCard,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        ),
      ),
    );
  }
}

class _DebitCardListTileWidget extends StatelessWidget {
  const _DebitCardListTileWidget({
    required this.debitCard,
  });

  final DebitCard debitCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args = CardInfoViewArgs(debitCard: debitCard);
        Get.offAllNamed(AppPages.cardInfo, arguments: args);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(int.parse(0xFFFBC3C5.toString())),
                Color(int.parse(0xFFA9BCEB.toString())),
              ],
              stops: const [
                0.1,
                1
              ]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetPath.visa,
              colorFilter: const ColorFilter.mode(
                AppColors.hF6F6F6,
                BlendMode.modulate, // Blend mode
              ),
              height: 12,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: debitCard.cardName,
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                CustomTextWidget(
                  text: '${debitCard.currency} ${debitCard.amount}',
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // CustomTextWidget(
                //   text: 'Acct. no:'.tr,
                //   color: AppColors.hF6F6F6,
                //   fontWeight: FontWeight.normal,
                //   fontSize: 12,
                // ),
                // CustomTextWidget(
                //   text: debitCards.accountNumber,
                //   color: AppColors.hF6F6F6,
                //   fontWeight: FontWeight.w600,
                //   fontSize: 15,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
