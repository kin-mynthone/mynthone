part of '../views/home_view.dart';

class _AnnouncementWidget extends GetView<HomeController> {
  const _AnnouncementWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 150,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return _AnnouncementCardWidget(
                index: index,
              );
            },
            itemCount: controller.announcement.length,
            autoplay: true,
            loop: false,
            viewportFraction: 0.85,
            scale: 0.9,
            pagination: const SwiperPagination(
              margin: EdgeInsets.only(top: 100),
              builder: DotSwiperPaginationBuilder(
                color: AppColors.hE8E8E8,
                activeColor: AppColors.hF87054,
              ),
            ),
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}

class _AnnouncementCardWidget extends GetView<HomeController> {
  final int index;
  const _AnnouncementCardWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final announcement = controller.announcement[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: index == 0
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.hE5EAFF,
                  width: 2,
                ),
              )
            : BoxDecoration(
                color: AppColors.hE5EAFF,
                borderRadius: BorderRadius.circular(15),
              ),
        child: Row(
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/mynthone-dev.appspot.com/o/gift.png?alt=media&token=4abad1fe-9675-4bb1-a76c-dd3be63521d0', // Replace with your actual image URL
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const SizedBox(
                    height: 25,
                    width: 25,
                    child: LoadingIndicator(
                      color: AppColors.hF87054,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 210,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: announcement.title,
                    color: AppColors.h403E51,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextWidget(
                    text: announcement.description,
                    color: AppColors.h8E8E8E,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
