import 'package:get/get.dart';

import '../controllers/edit_event_dashboard_controller.dart';

class EditEventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditEventDashboardController>(
      () => EditEventDashboardController(),
    );
  }
}
