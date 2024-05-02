part of '../views/home_view.dart';

class _AnnouncementListWidget extends GetView<HomeController> {
  const _AnnouncementListWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 110,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return _AnnouncementCardWidget(
                index: index,
              );
            },
            itemCount: controller.announcement.length,
            loop: false,
            viewportFraction: 0.85,
            scale: 0.9,
            pagination: const SwiperPagination(
              margin: EdgeInsets.only(top: 90),
              builder: DotSwiperPaginationBuilder(
                color: AppColors.hE8E8E8,
                size: 8,
                activeSize: 8,
                activeColor: AppColors.hE06144,
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: index == 0
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.hF2F4FE,
                  width: 2,
                ),
              )
            : BoxDecoration(
                color: AppColors.hF2F4FE,
                borderRadius: BorderRadius.circular(15),
              ),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
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
                      color: AppColors.hE06144,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    maxLines: 3,
                    overflow: null,
                    announcement.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.h403E51,
                        ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  announcement.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.h8E8E8E,
                        fontSize: 10,
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
