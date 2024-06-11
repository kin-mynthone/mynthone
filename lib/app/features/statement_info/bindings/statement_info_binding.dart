import 'package:get/get.dart';

import '../controllers/statement_info_controller.dart';

class StatementInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StatementInfoController());
  }
}
