import 'package:get/get.dart';

import '../controllers/transfer_fund_controller.dart';

class TransferFundBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferFundController());
  }
}
