import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/model/race_model/race_model.dart';

class UpdateRaceDashboardController extends GetxController {
  final String raceId;

  UpdateRaceDashboardController({required this.raceId});

  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form Controllers - initialized directly
  final TextEditingController raceNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  // State variables
  final Rx<RaceModel?> currentRace = Rx<RaceModel?>(null);
  final RxString errorMessage = RxString('');
  final RxBool isLoading = RxBool(false);
  final RxBool isUpdating = RxBool(false);

  // Race data
  final Rx<RaceModel?> race = Rx<RaceModel?>(null);

  Future<void> getRaceById(String raceId) async {
    try {
      isLoading.value = true;
      final docSnapshot = await _firestore.collection('race').doc(raceId).get();
      if (docSnapshot.exists) {
        race.value = RaceModel.fromFirestore(docSnapshot);

        // Update controller values
        raceNameController.text = race.value?.title ?? '';
        imageUrlController.text = race.value?.logoUrl ?? '';
      } else {
        errorMessage.value = 'Race not found';
        Get.snackbar('Error', 'Race not found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      errorMessage.value = 'Failed to get race: $e';
      Get.snackbar('Error', 'Failed to get race: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> updateRace(Map<String, dynamic> updateData) async {
    if (!formKey.currentState!.validate()) return;
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      if (updateData.isEmpty) {
        throw "No data provided for update";
      }

      await _firestore.collection('race').doc(raceId).update(updateData);
      raceNameController.clear();
      imageUrlController.clear();
      Get.back();
      Get.snackbar('Success', 'Race updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      if (Get.isDialogOpen!) Get.back();
      Get.snackbar('Error', 'Failed to update race: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  @override
  void onInit() {
    getRaceById(raceId);
    super.onInit();
  }

  @override
  void onClose() {
    raceNameController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }
}