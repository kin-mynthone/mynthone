import 'package:get/get.dart';

import '../controllers/card_info_controller.dart';

class CardInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CardInfoController());
  }
}
