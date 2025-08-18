import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_sport_easy/app/modules/single_race_event_dashboard/controllers/single_race_event_dashboard_controller.dart';

class CreateEventDashboardController extends GetxController {
final String raceID;
CreateEventDashboardController({required this.raceID});
  final singleRaceEventController=Get.find<SingleRaceEventDashboardController>();
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController broadcastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Date & Time
  var selectedDate = Rxn<DateTime>();
  var selectedTime = Rxn<TimeOfDay>();

  Future<void> pickDate({required BuildContext context}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> pickTime({required BuildContext context}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && context.mounted) {
      selectedTime.value = pickedTime;
      timeController.text = pickedTime.format(context);
    }
  }

  Future<void> addEvent({required BuildContext context, required String raceId}) async {
    if (!formKey.currentState!.validate()) return;

    try {
      // Combine date and time
      DateTime? eventDateTime;
      if (selectedDate.value != null && selectedTime.value != null) {
        eventDateTime = DateTime(
          selectedDate.value!.year,
          selectedDate.value!.month,
          selectedDate.value!.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute,
        );
      }

      // Create event data
      final eventData = {
        'title': broadcastNameController.text,
        'location': locationController.text,
        'date': selectedDate.value != null
            ? Timestamp.fromDate(selectedDate.value!)
            : null,
        'time': selectedTime.value != null
            ? {
          'hour': selectedTime.value!.hour,
          'minute': selectedTime.value!.minute,
        }
            : null,
        'fullDateTime': eventDateTime != null
            ? Timestamp.fromDate(eventDateTime)
            : null,
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference docRef =  await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .add(eventData);

      DocumentSnapshot snapshot = await docRef.get();
      if (snapshot.exists) {
        Get.snackbar('Success', 'Event created successfully');
        // Clear form fields
        broadcastNameController.clear();
        locationController.clear();
        dateController.clear();
        timeController.clear();
        selectedDate.value = null;
        selectedTime.value = null;

        //get all data
        singleRaceEventController.getEventsByRaceId(raceId);


      } else {
        Get.snackbar('Error', 'Event creation failed');

      }

    } catch (e) {
      Get.snackbar('Error', 'Failed to create event: $e');
    }
  }



  @override
  void dispose() {
    broadcastNameController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}