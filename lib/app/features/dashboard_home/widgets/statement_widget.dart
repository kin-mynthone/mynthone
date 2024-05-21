part of '../views/home_view.dart';

class _StatementWidget extends StatefulWidget {
  const _StatementWidget();

  @override
  State<_StatementWidget> createState() => _StatementWidgetState();
}

class _StatementWidgetState extends State<_StatementWidget> {
  final homeStatementController = HomeStatementController.find;

  late Worker _homeStatementWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _homeStatementWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _homeStatementWorker = ever(
      homeStatementController.status,
      (value) {
        if (value == HomeStatementStatus.error) {
          Log.printInfo(homeStatementController.currentState);
        }
        if (value == HomeStatementStatus.loading) {
          Log.printInfo(homeStatementController.currentState);
        }
        if (value == HomeStatementStatus.succeeded) {
          Log.printInfo(homeStatementController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StatementHeaderWidget(),
            HomeStatementController.find.isLoading
                ? _ShimmerListWidget()
                : const _StatementsListView()
          ],
        ),
      ),
    );
  }
}

class _StatementHeaderWidget extends StatelessWidget {
  const _StatementHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Statement'.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 15,
                    ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AssetPath.magnifier,
                  height: 15,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 0,
            color: AppColors.hD0D0D0,
          ),
        ],
      ),
    );
  }
}

class _StatementsListView extends GetView<HomeStatementController> {
  const _StatementsListView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          itemCount: controller.statement.length,
          itemBuilder: (context, index) {
            final statement = controller.statement[index];
            return _StatementListTileWidget(
              statement: statement,
            );
          },
        ),
      ),
    );
  }
}

class _StatementListTileWidget extends StatelessWidget {
  const _StatementListTileWidget({
    required this.statement,
  });

  final Statement statement;

  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(
          statement.sender.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h403E51,
              ),
        ),
        subtitle: Text(
          statement.reference,
          maxLines: 2,
          overflow: null,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.h8E8E8E,
                fontSize: 11,
              ),
        ),
        trailing: statement.received
            ? Text(
                '+ ${statement.currency} ${formatBalance.format(double.parse(statement.amount))}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.h1BBE49,
                    ),
              )
            : Text(
                '- ${statement.currency} ${formatBalance.format(double.parse(statement.amount))}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hF14C4C,
                    ),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          final args = StatementInfoViewArgs(statement: statement);
          //  Get.toNamed(AppPages.statementInfo, arguments: args);
        },
      ),
    );
  }
}

class _ShimmerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
        ],
      ),
    );
  }
}

class _ShimmerItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.hE8E8E8,
          highlightColor: AppColors.hF6F6F6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 250,
              height: 15,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.hE8E8E8,
          highlightColor: AppColors.hF6F6F6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 120,
              height: 15,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
