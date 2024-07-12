import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/beam_and_go/select_beneficiary/views/select_beneficiary_view.dart';
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
import '../controllers/merchants_controller.dart';

part '../Widget/shimmer_list_widget.dart';

class MerchantsViewArgs {
  final Account account;

  MerchantsViewArgs({
    required this.account,
  });
}

class MerchantsView extends StatefulWidget {
  const MerchantsView({super.key});

  @override
  State<MerchantsView> createState() => _MerchantsViewState();
}

class _MerchantsViewState extends State<MerchantsView> {
  final merchantsController = MerchantsController.find;
  final networkController = NetworkController.find;

  late Worker _merchantsWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _merchantsWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _merchantsWorker = ever(
      merchantsController.status,
      (value) {
        if (value == MerchantsStatus.error) {
          Log.printInfo(merchantsController.currentState);
          Log.printInfo(networkController.currentState);

          final title = 'Select Voucher'.tr;
          final message = merchantsController.errorMessage;

          if (networkController.checkConnectivityResult) {
            _showErrorDialog(context, title: title, message: message);
          }
        }
        if (value == MerchantsStatus.loading) {
          Log.printInfo(merchantsController.currentState);
        }
        if (value == MerchantsStatus.succeeded) {
          Log.printInfo(merchantsController.currentState);
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
          Obx(() => merchantsController.isLoading
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
    final merchantsViewArgs = Get.arguments as MerchantsViewArgs;

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
                      DashboardViewArgs(account: merchantsViewArgs.account);
                  Get.offAllNamed(AppPages.dashboard, arguments: args);
                },
                iconColor: AppColors.h403E51,
              ),
              Image.asset(
                AssetPath.beamAndGo,
                height: 50,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppPages.orderedVoucher);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.h2445D4,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VouchersListView extends GetView<MerchantsController> {
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

class _VoucherCardWidget extends GetView<MerchantsController> {
  const _VoucherCardWidget({
    required this.voucher,
  });

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    final merchantsViewArgs = Get.arguments as MerchantsViewArgs;

    return GestureDetector(
      onTap: () {
        controller.resetQuantity();
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _BottomSheetVoucherDetails(
                voucher: voucher, account: merchantsViewArgs.account);
          },
        );
      },
      child: CouponCard(
        height: 150,
        backgroundColor: AppColors.hF2F4FE,
        curveAxis: Axis.vertical,
        firstChild: Container(
          decoration: const BoxDecoration(
            color: AppColors.hE06144,
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.network(
                voucher.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
            ),
          ),
        ),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                voucher.description,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h8E8E8E,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              const Spacer(),
              Text(
                '${voucher.unitPrice} ${voucher.unitPriceCurrencyCode} ',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hE06144,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetVoucherDetails extends GetView<MerchantsController> {
  const _BottomSheetVoucherDetails({
    required this.voucher,
    required this.account,
  });

  final Voucher voucher;
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(
          AppNumbers.screenPadding, 0, AppNumbers.screenPadding, 50),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: Image.network(
                voucher.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                voucher.description,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h8E8E8E,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${voucher.unitPrice}  ${voucher.unitPriceCurrencyCode}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.hE06144,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(
            height: 40,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.quantity > voucher.minQty) {
                          controller.subtractQuantity();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.h2445D4,
                          padding: const EdgeInsets.all(0)),
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.hF2F4FE,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      ' ${controller.quantity}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.h403E51,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.quantity < voucher.maxQty) {
                          controller.addQuantity();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.h2445D4,
                          padding: const EdgeInsets.all(0)),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.hF2F4FE,
                      ),
                    ),
                  ),
                ],
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                final args = SelectBeneficiaryViewArgs(
                    voucher: voucher,
                    account: account,
                    quantity: controller.quantity);
                Get.toNamed(AppPages.selectBeneficiary, arguments: args);
              },
              child: Text(
                'Continue'.tr,
              )),
        ],
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
