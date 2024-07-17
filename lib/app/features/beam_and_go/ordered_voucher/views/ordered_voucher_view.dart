import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/beam_and_go/ordered_voucher_summary/views/ordered_voucher_summary_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../helpers/log_helper.dart';
import '../../../../models/ordered_voucher_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_alert_dialog_widget.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../../../../widgets/lost_connection_widget.dart';
import '../../../splash/controllers/network_controller.dart';
import '../controllers/ordered_voucher_controller.dart';

part '../Widget/shimmer_list_widget.dart';

class OrderedVoucherView extends StatefulWidget {
  const OrderedVoucherView({super.key});

  @override
  State<OrderedVoucherView> createState() => _OrderedVoucherViewState();
}

class _OrderedVoucherViewState extends State<OrderedVoucherView>
    with SingleTickerProviderStateMixin {
  final orderedVoucherController = OrderedVoucherController.find;
  final networkController = NetworkController.find;
  late Worker _orderedVoucherWorker;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _orderedVoucherWorker.dispose();
    _tabController.dispose();

    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _orderedVoucherWorker = ever(
      orderedVoucherController.status,
      (value) {
        if (value == OrderedVoucherStatus.error) {
          Log.printInfo(orderedVoucherController.currentState);
          Log.printInfo(networkController.currentState);

          final title = 'Select Voucher'.tr;
          final message = orderedVoucherController.errorMessage;

          if (networkController.checkConnectivityResult) {
            _showErrorDialog(context, title: title, message: message);
          }
        }
        if (value == OrderedVoucherStatus.loading) {
          Log.printInfo(orderedVoucherController.currentState);
        }
        if (value == OrderedVoucherStatus.succeeded) {
          Log.printInfo(orderedVoucherController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderWidget(),
          Container(
            color: AppColors.hF2F4FE,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.h403E51,
              labelColor: AppColors.h403E51,
              unselectedLabelColor: AppColors.h403E51,
              tabs: const [
                Tab(text: 'Purchased'),
                Tab(text: 'Redeemed'),
              ],
            ),
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Obx(() => orderedVoucherController.isLoading
                    ? Column(
                        children: [
                          _ShimmerListWidget(),
                        ],
                      )
                    : NetworkController.find.checkConnectivityResult
                        ? const _VouchersListView()
                        : const ConnectionLost()),
                Obx(() => orderedVoucherController.isLoading
                    ? Column(
                        children: [
                          _ShimmerListWidget(),
                        ],
                      )
                    : NetworkController.find.checkConnectivityResult
                        ? const _VouchersListView()
                        : const ConnectionLost()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends GetView<OrderedVoucherController> {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 0),
      color: AppColors.hF2F4FE,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            GoBackButton(
              onPressed: () => Get.back(closeOverlays: true),
              iconColor: AppColors.h403E51,
            ),
            Text(
              'Transactions'.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.h2445D4,
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ]

          //   DefaultTabController(
          //     length: 2,
          //     child: Center(
          //       child: ButtonsTabBar(
          //         radius: AppNumbers.inputBorderRadius,
          //         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          //         unselectedBackgroundColor: AppColors.h2445D4,
          //         decoration: const BoxDecoration(color: AppColors.h403E51),
          //         unselectedLabelStyle:
          //             Theme.of(context).textTheme.titleMedium?.copyWith(
          //                   color: AppColors.h8E8E8E,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //         labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          //               color: AppColors.h8E8E8E,
          //               fontSize: 12,
          //               fontWeight: FontWeight.w500,
          //             ),
          //         height: 56,
          //         onTap: (index) => {},
          //         tabs: const [
          //           Tab(
          //             text: "Received",
          //           ),
          //           Tab(
          //             text: "Transferred",
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
          ),
    );
  }
}

class _VouchersListView extends GetView<OrderedVoucherController> {
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
              final orderedVoucher = controller.voucher[index];
              return _VoucherCardWidget(orderedVoucher: orderedVoucher);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ),
      ),
    );
  }
}

class _VoucherCardWidget extends GetView<OrderedVoucherController> {
  const _VoucherCardWidget({
    required this.orderedVoucher,
  });

  final OrderedVoucher orderedVoucher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args =
            OrderedVoucherSummaryViewArgs(orderedVoucher: orderedVoucher);
        Get.toNamed(AppPages.orderedVoucherSummary, arguments: args);
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
                orderedVoucher.imageUrl,
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
                orderedVoucher.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                orderedVoucher.description,
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
                orderedVoucher.status,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hE06144,
                      fontSize: 22,
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
