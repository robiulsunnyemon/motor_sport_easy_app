import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateEventDashboardController extends GetxController {


  final TextEditingController eventNameController=TextEditingController();
  final TextEditingController locationController=TextEditingController();
  final TextEditingController dateController=TextEditingController();
  final TextEditingController timeController=TextEditingController();
  final TextEditingController sponsorNameController=TextEditingController();


  var selectedDate = Rxn<DateTime>();
  Future<void> pickDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      print(dateController.text);
    }
  }

  var selectedTime = Rxn<TimeOfDay>();
  Future<void> pickTime({required BuildContext context}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (!context.mounted) return;
    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      timeController.text = pickedTime.format(context);
      print(timeController.text);
    }
  }




  final formKey = GlobalKey<FormState>();

  String? formValidationFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }






  Future<void> createEvent({required BuildContext context}) async {


    try {
      await FirebaseFirestore.instance.collection('events').add({
        'title': eventNameController.text,
        'location': locationController.text,
        'date': dateController.text,
        'time': timeController.text,
        'sponsor': sponsorNameController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Event created successfully!");
    } catch (e) {
      print("Error creating event: $e");
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create event: $e")),
      );
    }
  }









  @override
  void dispose() {
    eventNameController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    sponsorNameController.dispose();
    super.dispose();
  }
}
