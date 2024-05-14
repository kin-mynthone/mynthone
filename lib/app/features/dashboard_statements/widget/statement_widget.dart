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
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(
          statement.senderName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h403E51,
                fontSize: 15,
              ),
        ),
        subtitle: Text(
          statement.note,
          maxLines: 2,
          overflow: null,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.h8E8E8E,
              ),
        ),
        trailing: statement.transactionType == 'Receive'
            ? Text(
                '+ ${statement.currency} ${statement.amount}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.h1BBE49,
                      fontSize: 15,
                    ),
              )
            : Text(
                '- ${statement.currency} ${statement.amount}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hF14C4C,
                      fontSize: 15,
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
