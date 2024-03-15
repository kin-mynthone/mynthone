import 'package:get/get.dart';
import 'package:mynthone/app/features/dashboard_card_list/controllers/card_list_controller.dart';

import '../../dashboard_home/controllers/home_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(CardListController());
  }
}
