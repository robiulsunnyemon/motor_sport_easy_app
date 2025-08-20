import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/event_model/event_model.dart';
import '../../../shared_pref_helper/shared_pref_helper.dart';
import '../widgets/set_notification_alert_dialog.dart';

class RacingDetailsController extends GetxController {
  RxInt setHour = 1.obs;
  RxBool is8Hour = false.obs;
  RxBool is3Hour = false.obs;
  RxBool is6Hour = false.obs;

  void increaseSetHour() {
    setHour.value++;
    update();
  }

  void decreaseSetHour() {
    if (setHour.value > 1) {
      setHour.value--;
      update();
    }
  }

  void set8Hour({
    required String eventName,
    required DateTime date,
    required int hour,
  }) {
    if (is8Hour.value == false) {
      sendNotificationToApi(eventName: eventName,date: date,hour: hour);
      is8Hour.value = true;
    } else {
      is8Hour.value = false;
    }
    update();
  }

  void set3Hour({
    required String eventName,
    required DateTime date,
    required int hour,
  }) {
    if (is3Hour.value == false) {
      sendNotificationToApi(eventName: eventName,date: date,hour: hour);
      is3Hour.value = true;
    } else {
      is3Hour.value = false;
    }
    update();
  }

  void set6Hour({
    required String eventName,
    required DateTime date,
    required int hour,
  }) {
    if (is6Hour.value == false) {
      sendNotificationToApi(eventName: eventName,date: date,hour: hour);
      is6Hour.value = true;
    } else {
      is6Hour.value = false;
    }
    update();
  }

  Future<void> showMyDialog({
    required BuildContext context,
    required String eventId,
    required String eventName,
    required DateTime eventDate,
    required int hour,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SetNotificationAlertDialog(
          eventId: eventId,
          raceId: '',
          eventName: eventName,
          eventDate: eventDate,
          hour: hour,
        );
      },
    );
  }

  final events = <EventModel>[].obs;
  final isLoading = false.obs;

  Future<void> getEventsByRaceId(String raceId) async {
    try {
      isLoading(true);
      events.clear();

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
    required String eventName,
    required DateTime date,
    required int hour,
  }) async {
    const String apiUrl =
        "https://motogp.mtscorporate.com/api/users/schedule-notification";
    String? uid = await SharedPrefHelper.getUid();
    if (uid != null) {
      String formattedEventDate = date.toUtc().toIso8601String();

      Map<String, dynamic> requestBody = {
        "uid": uid,
        "gameDetails": {
          "gameName": eventName,
          "gameTime": formattedEventDate,
        },
        "hoursBefore": hour,
      };
      print(hour);

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          print("Event notification set successfully");
          Get.back();
          Get.snackbar("Success", "Event notification set successfully");
        } else {
          print("Failed to set notification: ${response.body}");
          Get.snackbar("Error", "Failed to set notification");
        }
      } catch (e) {
        print("Error sending token to backend: $e");
        Get.snackbar("Error", "Failed to set notification");
      }
    }
  }

}
