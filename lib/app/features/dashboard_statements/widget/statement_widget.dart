part of '../views/statements_view.dart';

class _StatementWidget extends GetView<StatementController> {
  const _StatementWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
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
          // Get.toNamed(AppPages.statementInfo, arguments: args);
        },
      ),
    );
  }
}
