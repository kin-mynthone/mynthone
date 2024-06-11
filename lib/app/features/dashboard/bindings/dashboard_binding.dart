import 'package:get/get.dart';
import '../../beneficiary/controllers/beneficiary_controller.dart';
import '../../dashboard_home/controllers/home_controller.dart';
import '../../dashboard_home/controllers/home_statement_controller.dart';
import '../../dashboard_statements/controllers/statements_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(HomeStatementController());
    // Get.put(HomeCardsController());
    // Get.put(CardController());
    Get.put(StatementController());
    Get.put(BeneficiaryController());
  }
}
