import 'package:get/get.dart';

import '../controllers/deposit_instruction_controller.dart';

class DepositInstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DepositInstructionController());
  }
}
