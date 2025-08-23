import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class NotifyDashboardController extends GetxController {
  final TextEditingController notificationController = TextEditingController();


  Future<void> createRace({required BuildContext context}) async {

    try {

      final notifyData = {
        'title': notificationController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference docRef = await FirebaseFirestore.instance.collection('notify').add(notifyData);

      DocumentSnapshot snapshot = await docRef.get();
      if (snapshot.exists) {
        Get.snackbar('Success', 'race created successfully');
        // Clear form fields
        notificationController.clear();
      } else {
        Get.snackbar('Error', 'race creation failed');

      }


    } catch (e) {
      Get.snackbar('Error', 'Failed to create event: $e');
    }
  }

  @override
  void dispose() {
    notificationController.dispose();
    super.dispose();
  }
}
