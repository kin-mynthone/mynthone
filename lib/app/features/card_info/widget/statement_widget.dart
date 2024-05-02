part of '../views/card_info_view.dart';

class _StatementWidget extends StatelessWidget {
  const _StatementWidget();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatementHeaderWidget(),
          _StatementsListView(),
        ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statement'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.h403E51,
                  fontSize: 18,
                ),
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

class _StatementsListView extends GetView<CardInfoController> {
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
