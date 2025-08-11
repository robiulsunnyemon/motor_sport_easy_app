import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateEventDashboardController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController sponsorNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

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

  Future<void> createEvent({required BuildContext context}) async {
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
        'title': eventNameController.text,
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
        'sponsor': sponsorNameController.text,
        'logoUrl': imageUrlController.text.trim(), // সরাসরি ইউজারের দেওয়া URL ব্যবহার
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference docRef = await FirebaseFirestore.instance.collection('events').add(eventData);

      DocumentSnapshot snapshot = await docRef.get();
      if (snapshot.exists) {
        print('Event created successfully with ID: ${docRef.id}');
        Get.snackbar('Success', 'Event created successfully');
        // Clear form fields
        eventNameController.clear();
        locationController.clear();
        dateController.clear();
        timeController.clear();
        sponsorNameController.clear();
        imageUrlController.clear();
        selectedDate.value = null;
        selectedTime.value = null;

      } else {
        print('Event creation failed');
        Get.snackbar('Error', 'Event creation failed');

      }


    } catch (e) {
      Get.snackbar('Error', 'Failed to create event: $e');
    }
  }

  @override
  void dispose() {
    eventNameController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    sponsorNameController.dispose();
    imageUrlController.dispose(); // নতুন কন্ট্রোলার ডিসপোজ
    super.dispose();
  }
}