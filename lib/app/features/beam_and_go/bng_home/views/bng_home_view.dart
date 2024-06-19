import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../helpers/asset_path_helper.dart';
import '../../../../helpers/log_helper.dart';
import '../../../../models/account_model.dart';
import '../../../../models/voucher_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_alert_dialog_widget.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../../../../widgets/lost_connection_widget.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../../splash/controllers/network_controller.dart';
import '../controllers/bng_home_controller.dart';

part '../Widget/shimmer_list_widget.dart';
part '../Widget/voucher_card_widget.dart';

class BNGHomeViewArgs {
  final Account account;

  BNGHomeViewArgs({
    required this.account,
  });
}

class BNGHomeView extends StatefulWidget {
  const BNGHomeView({super.key});

  @override
  State<BNGHomeView> createState() => _BNGHomeViewState();
}

class _BNGHomeViewState extends State<BNGHomeView> {
  final bngHomeController = BNGHomeController.find;
  final networkController = NetworkController.find;

  late Worker _bngHomeWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _bngHomeWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _bngHomeWorker = ever(
      bngHomeController.status,
      (value) {
        if (value == BNGHomeStatus.error) {
          Log.printInfo(bngHomeController.currentState);
          Log.printInfo(networkController.currentState);

          final title = 'Select Voucher'.tr;
          final message = bngHomeController.errorMessage;

          if (networkController.checkConnectivityResult) {
            _showErrorDialog(context, title: title, message: message);
          }
        }
        if (value == BNGHomeStatus.loading) {
          Log.printInfo(bngHomeController.currentState);
        }
        if (value == BNGHomeStatus.succeeded) {
          Log.printInfo(bngHomeController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _HeaderWidget(),
          Obx(() => bngHomeController.isLoading
              ? _ShimmerListWidget()
              : NetworkController.find.checkConnectivityResult
                  ? const _VouchersListView()
                  : const ConnectionLost()),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    final bngHomeViewArgs = Get.arguments as BNGHomeViewArgs;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoBackButton(
                onPressed: () {
                  final args =
                      DashboardViewArgs(account: bngHomeViewArgs.account);
                  Get.offAllNamed(AppPages.dashboard, arguments: args);
                },
                iconColor: AppColors.h403E51,
              ),
              Image.asset(
                AssetPath.beamAndGo,
                height: 50,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VouchersListView extends GetView<BNGHomeController> {
  const _VouchersListView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppNumbers.screenPadding,
          ),
          child: ListView.separated(
            itemCount: controller.voucher.length,
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              final voucher = controller.voucher[index];
              return _VoucherCardWidget(voucher: voucher);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ),
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
