import 'package:get/get.dart';

import '../controllers/select_beneficiary_controller.dart';

class SelectBeneficiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectBeneficiaryController());
  }
}
