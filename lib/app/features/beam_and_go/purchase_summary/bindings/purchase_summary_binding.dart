import 'package:get/get.dart';

import '../controllers/purchase_summary_controller.dart';

class PurchaseSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseSummaryController());
  }
}
