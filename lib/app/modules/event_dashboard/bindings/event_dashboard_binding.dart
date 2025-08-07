import 'package:get/get.dart';

import '../controllers/event_dashboard_controller.dart';

class EventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventDashboardController>(
      () => EventDashboardController(),
    );
  }
}
