import 'package:get/get.dart';

import '../controllers/select_account_controller.dart';

class SelectAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectAccountController());
  }
}
