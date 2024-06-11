import 'package:get/get.dart';
import 'package:mynthone/app/features/transfer_fund/controllers/local_auth_controller.dart';

import '../controllers/transfer_fund_controller.dart';

class TransferFundBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferFundController());
    Get.put(LocalAuthController());
  }
}
