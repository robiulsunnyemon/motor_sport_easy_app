import 'package:get/get.dart';

import '../controllers/single_race_event_dashboard_controller.dart';

class SingleRaceEventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    final raceId = Get.parameters['raceId'] ??
        Get.arguments?['raceId']?.toString();

    if (raceId == null || raceId.isEmpty) {
      throw "Race ID is required for SingleRaceEventDashboardController";
    }
    Get.lazyPut<SingleRaceEventDashboardController>(
      () => SingleRaceEventDashboardController(
        raceID: raceId,
      ),
    );
  }
}
