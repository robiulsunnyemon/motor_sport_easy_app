
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/model/event_model/event_model.dart';
import '../../../shared_pref_helper/shared_pref_helper.dart';



class RacingDetailsController extends GetxController {
  final String raceId;
  final String raceName;

  RacingDetailsController({required this.raceId,required this.raceName});

  final RxString _currentRaceId = ''.obs;
  String get currentRaceId => _currentRaceId.value;
  set currentRaceId(String value) => _currentRaceId.value = value;

  RxBool is12Hour = false.obs;
  RxBool is3Hour = false.obs;
  RxBool is1Hour = false.obs;

  final events = <EventModel>[].obs;
  final isLoading = false.obs;


  Future<void> _loadNotificationState() async {
    final state = await SharedPrefHelper.getNotificationState(currentRaceId);
    is12Hour.value = state['8hour'] ?? false;
    is3Hour.value = state['3hour'] ?? false;
    is1Hour.value = state['6hour'] ?? false;
  }


  Future<void> _saveNotificationState() async {
    final state = {
      '12hour': is12Hour.value,
      '3hour': is3Hour.value,
      '6hour': is1Hour.value,
    };
    await SharedPrefHelper.saveNotificationState(currentRaceId, state);
  }

  void set12Hour() {
    is12Hour.value = !is12Hour.value;
    _saveNotificationState();

    if (is12Hour.value) {
      checkEventData(hour: 12);
    }
  }

  void set3Hour() {
    is3Hour.value = !is3Hour.value;
    _saveNotificationState();

    if (is3Hour.value) {
      checkEventData(hour: 3);
    }
  }

  void set1Hour() {
    is1Hour.value = !is1Hour.value;
    _saveNotificationState();

    if (is1Hour.value) {
      checkEventData(hour: 1);
    }
  }

  Future<void> getEventsByRaceId(String raceId) async {
    try {
      isLoading(true);
      events.clear();
      currentRaceId = raceId;

      // Notification state লোড করুন
      await _loadNotificationState();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();

      events.assignAll(
        querySnapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load events: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendNotificationToApi({
    required String location,
    required DateTime date,
    required int hour,
  }) async {
    const String apiUrl = "https://motogp.mtscorporate.com/api/users/schedule-notification";
    String? uid = await SharedPrefHelper.getUid();
    print(hour);
    if (uid != null) {
      String formattedEventDate = date.toUtc().toIso8601String();

      Map<String, dynamic> requestBody = {
        "uid": uid,
        "gameDetails": {
          "gameName": "$raceName at $location",
          "gameTime": formattedEventDate,
        },
        "hoursBefore": hour,
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          print("Notification set successfully for $location");
        } else {
          print("Failed to set notification. Status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error sending notification: $e");
      }
    }
  }

  void checkEventData({required int hour}) {
    for(var event in events) {
      sendNotificationToApi(
          location: event.location,
          date: event.fullDateTime,
          hour: hour
      );
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    getEventsByRaceId(raceId);
    super.onInit();
  }




}





