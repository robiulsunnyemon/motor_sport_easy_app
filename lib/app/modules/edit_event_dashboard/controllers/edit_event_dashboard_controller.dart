import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';

import '../../../data/model/event_model/event_model.dart';

class EditEventDashboardController extends GetxController {
  final String raceId;
  final String eventId;
  EditEventDashboardController({required this.raceId, required this.eventId});

  final Rx<EventModel?> event = Rx<EventModel?>(null);
  final RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController broadcastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sponsorController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();
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
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime != null && context.mounted) {
      selectedTime.value = pickedTime;
      timeController.text = pickedTime.format(context);
    }
  }

  Future<void> getEventById(String raceId, String eventId) async {
    try {
      isLoading(true);
      final docSnapshot = await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .doc(eventId)
          .get();

      if (docSnapshot.exists) {
        event.value = EventModel.fromFirestore(docSnapshot);

        // Set all fields from the event model
        broadcastNameController.text = event.value?.broadcastChannel ?? '';
        locationController.text = event.value?.location ?? '';
        sponsorController.text = event.value?.sponsor ?? '';
        logoUrlController.text = event.value?.logoUrl ?? '';

        // Set date
        if (event.value?.date != null) {
          selectedDate.value = event.value!.date;
          dateController.text = DateFormat('dd/MM/yyyy').format(event.value!.date);
        }

        // Set time
        if (event.value?.time != null) {
          selectedTime.value = TimeOfDay(
            hour: event.value!.time.hour,
            minute: event.value!.time.minute,
          );
          timeController.text = event.value!.time.formattedTime;
        }
      } else {
        Get.snackbar('Error', 'Event not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch event: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateEvent() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading(true);

      // Validate required fields
      if (selectedDate.value == null || selectedTime.value == null) {
        throw "Date and time are required";
      }

      // Create fullDateTime by combining date and time
      final fullDateTime = DateTime(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
        selectedTime.value!.hour,
        selectedTime.value!.minute,
      );

      final eventData = {
        'title': broadcastNameController.text,
        'location': locationController.text,
        'sponsor': sponsorController.text,
        'logoUrl': logoUrlController.text,
        'date': Timestamp.fromDate(selectedDate.value!),
        'time': {
          'hour': selectedTime.value!.hour,
          'minute': selectedTime.value!.minute,
        },
        'fullDateTime': Timestamp.fromDate(fullDateTime),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .doc(eventId)
          .update(eventData);

      Get.snackbar('Success', 'Event updated successfully');

      broadcastNameController.clear();
      locationController.clear();
      sponsorController.clear();
      logoUrlController.clear();
      dateController.clear();
      timeController.clear();
      selectedDate.value = null;
      selectedTime.value = null;
      
      Get.toNamed(Routes.RACE_ADMIN);

    } catch (e) {
      Get.snackbar('Error', 'Failed to update event: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getEventById(raceId, eventId);
    super.onInit();
  }

  @override
  void onClose() {
    broadcastNameController.dispose();
    locationController.dispose();
    sponsorController.dispose();
    logoUrlController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }
}