part of '../views/card_info_view.dart';

class _BlockThisCardWidget extends GetView<CardInfoController> {
  const _BlockThisCardWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.hBDBDBD,
            ),
            label: Text(
              'Block this card'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.h403E51,
                    fontSize: 13,
                  ),
            ),
            icon: SvgPicture.asset(
              AssetPath.block,
              height: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    AssetPath.info,
                  )),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Once blocked, this card will no longer be accepted for online payments or for over the counter transaction. This action cannot be undone.',
                  maxLines: 3,
                  overflow: null,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.h8E8E8E,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
