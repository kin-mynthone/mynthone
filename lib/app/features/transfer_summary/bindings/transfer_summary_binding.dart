import 'package:get/get.dart';

import '../controllers/transfer_summary_controller.dart';

class TransferSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferSummaryController());
  }
}
