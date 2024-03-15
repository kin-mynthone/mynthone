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
    final debitCards = controller.debitCards[index];
    return Container(
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
    );
  }
}
