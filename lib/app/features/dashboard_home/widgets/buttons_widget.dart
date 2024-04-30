part of '../views/home_view.dart';

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppNumbers.screenPadding),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hF2F4FE,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    AssetPath.transfer,
                    height: 20,
                  ),
                  CustomTextWidget(
                    text: 'Transfer'.tr,
                    color: AppColors.h403E51,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hF2F4FE,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    AssetPath.receive,
                    height: 20,
                  ),
                  CustomTextWidget(
                    text: 'Request'.tr,
                    color: AppColors.h403E51,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 60,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.h425AC2,
                  padding: const EdgeInsets.all(0)),
              child: SvgPicture.asset(
                AssetPath.options,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
