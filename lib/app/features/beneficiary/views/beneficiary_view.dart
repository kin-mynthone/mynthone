import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/log_helper.dart';
import '../../../models/beneficiary_model.dart';
import '../../../themes/app_colors.dart';
import '../controllers/beneficiary_controller.dart';

class BeneficiaryView extends StatefulWidget {
  const BeneficiaryView({super.key});

  @override
  State<BeneficiaryView> createState() => _BeneficiaryViewState();
}

class _BeneficiaryViewState extends State<BeneficiaryView> {
  final beneficiaryController = BeneficiaryController.find;

  late Worker _beneficiaryWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _beneficiaryWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _beneficiaryWorker = ever(
      beneficiaryController.status,
      (value) {
        if (value == BeneficiaryStatus.error) {
          Log.printInfo(beneficiaryController.currentState);
        }
        if (value == BeneficiaryStatus.loading) {
          Log.printInfo(beneficiaryController.currentState);
        }
        if (value == BeneficiaryStatus.succeeded) {
          Log.printInfo(beneficiaryController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_HeaderWidget(), _BeneficiaryWidget()],
      ),
    );
  }
}

class _HeaderWidget extends GetView<BeneficiaryController> {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beneficiary'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.h2445D4,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Your previous beneficiary are listed here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.h403E51,
                ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _BeneficiaryWidget extends GetView<BeneficiaryController> {
  const _BeneficiaryWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.beneficiary.length,
          itemBuilder: (context, index) {
            final beneficiary = controller.beneficiary[index];
            return _BeneficiaryListTileWidget(
              beneficiary: beneficiary,
            );
          },
        ),
      ),
    );
  }
}

class _BeneficiaryListTileWidget extends StatelessWidget {
  const _BeneficiaryListTileWidget({
    required this.beneficiary,
  });

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(
          beneficiary.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h403E51,
              ),
        ),
        subtitle: Text(
          beneficiary.accountNumber.accountNumber,
          maxLines: 2,
          overflow: null,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.h8E8E8E,
                fontSize: 11,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          //final args = BeneficiaryInfoViewArgs(beneficiary: beneficiary);
          // Get.toNamed(AppPages.beneficiaryInfo, arguments: args);
        },
      ),
    );
  }
}
