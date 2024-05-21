import 'package:get/get.dart';
import '../../beneficiaries/controllers/beneficiaries_controller.dart';
import '../../dashboard_home/controllers/home_controller.dart';
import '../../dashboard_statements/controllers/statements_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    // Get.put(CardListController());
    Get.put(StatementController());
    Get.put(BeneficiariesController());
  }
}
