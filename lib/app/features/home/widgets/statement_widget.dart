part of '../views/home_view.dart';

class _StatementWidget extends StatelessWidget {
  const _StatementWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextWidget(
                text: 'Statement'.tr,
                color: AppColors.h403E51,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AssetPath.magnifier,
                  height: 20,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AppColors.hE8E8E8,
          ),
        ],
      ),
    );
  }
}
