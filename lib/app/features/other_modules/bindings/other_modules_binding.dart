import 'package:get/get.dart';

import '../controllers/other_modules_controller.dart';

class OtherModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtherModulesController());
  }
}
