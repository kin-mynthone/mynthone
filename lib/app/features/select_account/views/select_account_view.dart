import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../constants/app_numbers.dart';
import '../../../helpers/log_helper.dart';
import '../../../models/account_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_alert_dialog_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../../../widgets/lost_connection_widget.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../splash/controllers/network_controller.dart';
import '../controllers/select_account_controller.dart';

class SelectAccountView extends StatefulWidget {
  const SelectAccountView({super.key});

  @override
  State<SelectAccountView> createState() => _SelectAccountViewState();
}

class _SelectAccountViewState extends State<SelectAccountView> {
  final selectAccountController = SelectAccountController.find;
  final networkController = NetworkController.find;

  late Worker _selectAccountWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _selectAccountWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _selectAccountWorker = ever(
      selectAccountController.status,
      (value) {
        if (value == SelectAccountStatus.error) {
          Log.printInfo(selectAccountController.currentState);
          Log.printInfo(networkController.currentState);

          final title = 'Select Account'.tr;
          final message = selectAccountController.errorMessage;

          if (networkController.checkConnectivityResult) {
            _showErrorDialog(context, title: title, message: message);
          }
        }
        if (value == SelectAccountStatus.loading) {
          Log.printInfo(selectAccountController.currentState);
        }
        if (value == SelectAccountStatus.succeeded) {
          Log.printInfo(selectAccountController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectAccountController.isLoading ? false : true,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.h2445D4,
            body: SafeArea(
              minimum: const EdgeInsets.symmetric(
                horizontal: AppNumbers.screenPadding,
                vertical: AppNumbers.screenPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => NetworkController.find.checkConnectivityResult
                      ? const _AccountsListView()
                      : const ConnectionLost())
                ],
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() {
    return Obx(
        () => LoadingOverlay(isLoading: selectAccountController.isLoading));
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your account'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.hF6F6F6,
                fontSize: 22,
              ),
        ),
        Text(
          'Please select one of your account to proceed'.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.hF6F6F6,
                fontSize: 13,
              ),
        ),
      ],
    );
  }
}

class _AccountsListView extends GetView<SelectAccountController> {
  const _AccountsListView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.separated(
          itemCount: controller.accounts.length,
          itemBuilder: (context, index) {
            final account = controller.accounts[index];
            return _AccountListTileWidget(account: account);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        ),
      ),
    );
  }
}

class _AccountListTileWidget extends StatelessWidget {
  const _AccountListTileWidget({
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          account.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h403E51,
                fontSize: 18,
              ),
        ),
        onTap: () {
          final args = DashboardViewArgs(account: account);
          Get.offAllNamed(AppPages.dashboard, arguments: args);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.hE06144,
        ),
        tileColor: AppColors.hF6F6F6,
      ),
    );
  }
}

Future<void> _showErrorDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
          canPop: false,
          child: CustomAlertDialogWidget(
            title: title,
            message: message,
            onPressed: () {},
          ));
    },
  );
}
