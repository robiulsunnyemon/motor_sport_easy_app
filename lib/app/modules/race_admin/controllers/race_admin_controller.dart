import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../data/model/race_model/race_model.dart';
import 'package:flutter/material.dart';

class RaceAdminController extends GetxController {
  final RxList<RaceModel> raceList = <RaceModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchRaces();
    super.onInit();
  }

  Future<void> fetchRaces() async {
    try {
      _firestore.collection('race').snapshots().listen((QuerySnapshot snapshot) {
        raceList.assignAll(
          snapshot.docs.map((doc) => RaceModel.fromFirestore(doc)).toList(),
        );

      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch races: $e');
    }
  }


  Future<void> deleteRace(String raceId) async {
    try {
      // Show loading dialog
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Delete from Firestore
      await _firestore.collection('race').doc(raceId).delete();

      // Remove from local list
      raceList.removeWhere((race) => race.id == raceId);

      // Close dialog
      Get.back();

      // Show success message
      Get.snackbar('Success', 'Race deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      // Close dialog if open
      if (Get.isDialogOpen!) Get.back();

      // Show error message
      Get.snackbar('Error', 'Failed to delete race: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  Future<void> updateRace(String raceId, Map<String, dynamic> updateData) async {
    try {
      // Show loading dialog
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Validate update data
      if (updateData.isEmpty) {
        throw "No data provided for update";
      }

      // Update in Firestore
      await _firestore.collection('race').doc(raceId).update(updateData);

      // Update in local list
      final index = raceList.indexWhere((race) => race.id == raceId);
      if (index != -1) {
        fetchRaces();
      }

      // Close dialog
      Get.back();

      // Show success message
      Get.snackbar('Success', 'Race updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      // Close dialog if open
      if (Get.isDialogOpen!) Get.back();

      // Show error message
      Get.snackbar('Error', 'Failed to update race: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }



  @override
  void onClose() {
    raceList.clear();
    super.onClose();
  }
}
