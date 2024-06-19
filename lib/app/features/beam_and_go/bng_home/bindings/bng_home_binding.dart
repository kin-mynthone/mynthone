import 'package:get/get.dart';

import '../controllers/bng_home_controller.dart';

class BNGHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BNGHomeController());
  }
}
