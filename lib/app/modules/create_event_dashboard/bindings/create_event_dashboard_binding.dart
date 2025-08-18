import 'package:get/get.dart';

import '../controllers/create_event_dashboard_controller.dart';

class CreateEventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    final raceId = Get.parameters['raceId'] ?? Get.arguments["raceId"];
    if (raceId == null || raceId.isEmpty) {

    }
    Get.lazyPut<CreateEventDashboardController>(
      () => CreateEventDashboardController(
        raceID: raceId,
      ),
    );
  }
}
