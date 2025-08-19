import 'package:get/get.dart';

import '../controllers/login_dashboard_controller.dart';

class LoginDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDashboardController>(
      () => LoginDashboardController(),
    );
  }
}
