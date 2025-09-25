import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../api_services/event_api_services/event_api_services.dart';
import '../../../data/api_model/event_api_model.dart';

class EventController extends GetxController {

  // final allEvents = <Map<String, dynamic>>[].obs;
  //
  // Future<void> fetchAllEvents() async {
  //   try {
  //     // ডেটা লোড হওয়ার আগে লিস্ট খালি করা হয়েছে
  //     allEvents.clear();
  //
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collectionGroup('events')
  //         .orderBy('fullDateTime')
  //         .get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // লুপ করে প্রতিটি ডকুমেন্ট থেকে ডেটা বের করে allEvents লিস্টে যুক্ত করা হয়েছে
  //       for (var doc in querySnapshot.docs) {
  //         Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
  //         allEvents.add(eventData);
  //       }
  //       print('মোট ${allEvents.length} টি ইভেন্ট লোড করা হয়েছে।');
  //     } else {
  //       print('কোনো ইভেন্ট পাওয়া যায়নি।');
  //     }
  //   } catch (e) {
  //     print('ইভেন্ট আনতে ব্যর্থ: $e');
  //   }
  // }
  //
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   fetchAllEvents();
  //   super.onInit();
  // }


  var allEvents = <EventAPIModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  void fetchEvents() async {
    try {
      isLoading.value = true;
      final fetchedEvents = await EventApiService.fetchEvents();
      allEvents.assignAll(fetchedEvents);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}