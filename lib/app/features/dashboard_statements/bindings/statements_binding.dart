import 'package:get/get.dart';

import '../controllers/statements_controller.dart';

class StatementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StatementController());
  }
}
