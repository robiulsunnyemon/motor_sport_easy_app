import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/model/event_model/event_model.dart';

class SingleRaceEventDashboardController extends GetxController {
  final String raceID;
  SingleRaceEventDashboardController({required this.raceID});

  final events = <EventModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    getEventsByRaceId(raceID);
    super.onInit();
  }

  Future<void> getEventsByRaceId(String raceId) async {
    try {
      isLoading(true);
      events.clear();
      update();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();


      events.assignAll(
          querySnapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList()
      );

    } catch (e) {
      Get.snackbar('Error', 'Failed to load events: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance
          .collection('race')
          .doc(raceID)
          .collection('events')
          .doc(eventId)
          .delete();

      events.removeWhere((event) => event.id == eventId);
      Get.snackbar('Success', 'Event deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete event: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


}
