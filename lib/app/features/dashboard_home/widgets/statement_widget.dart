part of '../views/home_view.dart';

class _StatementWidget extends StatelessWidget {
  const _StatementWidget();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_StatementHeaderWidget(), _StatementsListView()],
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

class _StatementsListView extends GetView<HomeController> {
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
        trailing: statement.reference == 'Receive'
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
        onTap: () {},
      ),
    );
  }
}
