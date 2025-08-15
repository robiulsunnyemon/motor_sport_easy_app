import 'package:get/get.dart';

import '../controllers/update_race_dashboard_controller.dart';

class UpdateRaceDashboardBinding extends Bindings {
  @override
  void dependencies() {
    final raceId = Get.parameters['raceId'] ??
        Get.arguments?['raceId']?.toString();

    if (raceId == null || raceId.isEmpty) {
      throw "Race ID is required for SingleRaceEventDashboardController";
    }
    Get.lazyPut<UpdateRaceDashboardController>(
      () => UpdateRaceDashboardController(
        raceId: raceId,
      ),
    );
  }
}
