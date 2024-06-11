part of '../views/home_view.dart';

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget();

  @override
  Widget build(BuildContext context) {
    final dashboardViewArgs = Get.arguments as DashboardViewArgs;
    return Padding(
      padding: const EdgeInsets.all(AppNumbers.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                final args =
                    TransferFundViewArgs(account: dashboardViewArgs.account);
                Get.toNamed(AppPages.transferFund, arguments: args);
              },
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
                  Text(
                    'Transfer'.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.h403E51,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
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
                  Text(
                    'Request'.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.h403E51,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 50,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.h2445D4,
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
