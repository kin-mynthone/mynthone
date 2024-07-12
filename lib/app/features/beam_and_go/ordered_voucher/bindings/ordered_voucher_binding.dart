import 'package:get/get.dart';

import '../controllers/ordered_voucher_controller.dart';

class OrderedVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderedVoucherController());
  }
}
