part of '../views/home_view.dart';

class _StatementWidget extends StatelessWidget {
  const _StatementWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_StatementHeaderWidget(), _StatementsListView()],
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
          Divider(
            thickness: 1,
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
      () => SizedBox(
        height: 200,
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
        title: CustomTextWidget(
          text: statement.senderName,
          color: AppColors.h403E51,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        subtitle: CustomTextWidget(
          text: statement.note,
          overflow: false,
          color: AppColors.h8E8E8E,
          fontSize: 13,
        ),
        trailing: statement.transactionType == 'Receive'
            ? CustomTextWidget(
                text: '+ ${statement.currency} ${statement.amount}',
                color: AppColors.h7CD0AD,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              )
            : CustomTextWidget(
                text: '- ${statement.currency} ${statement.amount}',
                color: AppColors.hF05C5C,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {},
      ),
    );
  }
}
