import 'package:get/get.dart';

import '../controllers/merchants_controller.dart';

class MerchantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MerchantsController());
  }
}
