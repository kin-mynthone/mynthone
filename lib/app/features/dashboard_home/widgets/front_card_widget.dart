part of '../views/home_view.dart';

class _FrontCardWidget extends GetView<HomeController> {
  const _FrontCardWidget();

  @override
  Widget build(BuildContext context) {
    final dashboardViewArgs = Get.arguments as DashboardViewArgs;
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.h2445D4,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account no.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.hF6F6F6,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${dashboardViewArgs.account.accountNumber.accountNumber}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hF6F6F6,
                      fontSize: 20,
                    ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.hF6F6F6,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${dashboardViewArgs.account.currency.symbolPrefix} ${formatBalance.format(double.parse(dashboardViewArgs.account.balance))}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hF6F6F6,
                      fontSize: 25,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
