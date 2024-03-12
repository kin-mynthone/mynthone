import 'package:get/get.dart';

import '../../dashboard_home/controllers/home_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
  }
}
