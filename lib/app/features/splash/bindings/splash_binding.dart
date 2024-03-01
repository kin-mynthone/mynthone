import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(AuthController(), permanent: true);
  }
}
