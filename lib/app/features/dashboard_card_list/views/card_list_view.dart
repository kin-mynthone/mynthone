import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/debit_card_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../card_info/views/card_info_view.dart';
import '../controllers/card_list_controller.dart';

class CardListView extends StatelessWidget {
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

class _HeaderWidget extends GetView<CardListController> {
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
              Text(
                'Your Cards'.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.h2445D4,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Total Cards: ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.h403E51,
                        ),
                  ),
                  Text(
                    '${controller.debitCards.length}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.h403E51,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_outlined,
              color: AppColors.hE06144,
              size: 25,
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
        Get.toNamed(AppPages.cardInfo, arguments: args);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.h2445D4,
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
              height: 15,
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  debitCard.cardName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.hF6F6F6,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${debitCard.currency} ${debitCard.amount}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.hF6F6F6,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
