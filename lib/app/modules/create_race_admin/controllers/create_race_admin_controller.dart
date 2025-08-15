import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class CreateRaceAdminController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController raceNameController = TextEditingController();
  final TextEditingController sponsorNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();



  Future<void> createRace({required BuildContext context}) async {
    if (!formKey.currentState!.validate()) return;

    try {


      // Create race data
      final raceData = {
        'title': raceNameController.text,
        'logoUrl': imageUrlController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference docRef = await FirebaseFirestore.instance.collection('race').add(raceData);

      DocumentSnapshot snapshot = await docRef.get();
      if (snapshot.exists) {

        Get.snackbar('Success', 'race created successfully');
        // Clear form fields
        raceNameController.clear();
        sponsorNameController.clear();
        imageUrlController.clear();
        formKey.currentState!.reset();

      } else {

        Get.snackbar('Error', 'race creation failed');

      }


    } catch (e) {
      Get.snackbar('Error', 'Failed to create event: $e');
    }
  }

  @override
  void dispose() {
    raceNameController.dispose();
    sponsorNameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }
}
