import 'package:get/get.dart';
import '../controllers/edit_event_dashboard_controller.dart';

class EditEventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    final raceId = Get.parameters['raceId'] ??
        Get.arguments?['raceId']?.toString();

    if (raceId == null || raceId.isEmpty) {
      throw "Race ID is required for edit event dashboard controller";
    }
    final evenId = Get.parameters['eventId'] ??
        Get.arguments?['evenId']?.toString();

    if (evenId == null || evenId.isEmpty) {
      throw "evenId ID is required for edit event dashboard controller";
    }
    Get.lazyPut<EditEventDashboardController>(
      () => EditEventDashboardController(
        raceId: raceId,
        eventId: evenId
      ),
    );
  }
}
