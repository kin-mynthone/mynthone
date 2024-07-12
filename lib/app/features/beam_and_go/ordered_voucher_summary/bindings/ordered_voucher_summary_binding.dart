import 'package:get/get.dart';

import '../controllers/ordered_voucher_summary_controller.dart';

class OrderedVoucherSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderedVoucherSummaryController());
  }
}
