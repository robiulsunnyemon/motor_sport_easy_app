import 'package:get/get.dart';

import '../controllers/notify_dashboard_controller.dart';

class NotifyDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifyDashboardController>(
      () => NotifyDashboardController(),
    );
  }
}
