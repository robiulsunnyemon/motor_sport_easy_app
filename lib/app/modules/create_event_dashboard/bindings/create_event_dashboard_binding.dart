import 'package:get/get.dart';

import '../controllers/create_event_dashboard_controller.dart';

class CreateEventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEventDashboardController>(
      () => CreateEventDashboardController(),
    );
  }
}
