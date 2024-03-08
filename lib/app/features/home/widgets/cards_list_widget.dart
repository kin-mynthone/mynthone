part of '../views/home_view.dart';

class _CardsListWidget extends GetView<HomeController> {
  const _CardsListWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 200,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return _CardsWidget(
              index: index,
            );
          },
          itemCount: controller.debitCards.length,
          viewportFraction: 0.85,
          loop: false,
          scale: 0.9,
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
    final debitCards = controller.debitCards[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(
            width: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: debitCards.cardName,
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                CustomTextWidget(
                  text: '${debitCards.currency} ${debitCards.amount}',
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextWidget(
                  text: 'Acct. no:'.tr,
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                CustomTextWidget(
                  text: debitCards.accountNumber,
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
