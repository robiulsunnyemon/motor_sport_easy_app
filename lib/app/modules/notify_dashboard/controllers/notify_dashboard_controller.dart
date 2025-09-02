import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;


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

  Future<void> createNotification()async{
    try {
      final notifyData = {

        'message': notificationController.text,
        "title": "Important announcement from Flutter team!",
      };
      final response=await https.post(
        Uri.parse('https://motogp.mtscorporate.com/api/notifications/admin/broadcast'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(notifyData),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Notification created successfully');
        // Clear form fields
        notificationController.clear();
      } else {
        Get.snackbar('Error', 'Notification creation failed');
      }
    }catch(e){
      Get.snackbar('Error', 'Failed to create Notification: $e');
    }

  }

  @override
  void dispose() {
    notificationController.dispose();
    super.dispose();
  }
}
