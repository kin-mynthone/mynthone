import 'package:get/get.dart';

import '../controllers/transfer_confirmation_controller.dart';

class TransferConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferConfirmationController());
  }
}
