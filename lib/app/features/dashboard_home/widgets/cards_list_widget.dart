part of '../views/home_view.dart';

class _CardsListWidget extends GetView<HomeController> {
  const _CardsListWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 140,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return _CardsWidget(
              index: index,
            );
          },
          itemCount: controller.debitCards.length,
          viewportFraction: 0.8,
          scale: 0.8,
          onTap: (index) {},
        ),
      ),
    );
  }
}

class _CardsWidget extends GetView<HomeController> {
  final int index;
  const _CardsWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final debitCard = controller.debitCards[index];
    return GestureDetector(
      onTap: () {
        final args = CardInfoViewArgs(debitCard: debitCard);
        Get.offAllNamed(AppPages.cardInfo, arguments: args);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.h425AC2,
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
                const SizedBox(
                  height: 5,
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
                //   text: debitCard.accountNumber,
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
