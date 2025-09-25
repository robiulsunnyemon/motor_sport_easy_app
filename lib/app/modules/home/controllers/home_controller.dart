import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api_services/race_api_services/race_api_services.dart';
import '../../../data/api_model/race_api_model.dart';
import '../../../data/model/race_model/race_model.dart';
import '../../../routes/app_pages.dart';
import '../../../shared_pref_helper/shared_pref_helper.dart';
import '../../widgets/custom_elevated_button.dart';

class HomeController extends GetxController {

  final TextEditingController requestRaceNameController=TextEditingController();
  final TextEditingController reportMessageController=TextEditingController();

  Future<void> showRequestDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       return AlertDialog(
         backgroundColor: Colors.white,
         title: Text(
           'Request',
           style: TextStyle(
             color: Colors.black,
             fontSize: 16,
             fontFamily: 'Inter',
             fontWeight: FontWeight.w400,
           ),
         ),
         content: SizedBox(
             height: 10,
           width: 300,
         ),
         actions: <Widget>[
           CustomElevatedButton(
             level: "Request a racing series",
             onTap: (){
               Get.back();
               showRequestSeriesDialog(context);
             },
           ),
           SizedBox(height: 10,),
           CustomElevatedButton(
             level: "Report",
             onTap: (){
               Get.back();
               showRequestReportDialog(context);
             },
             isBackgroundWhite: true,
             isBorderRed: true,
           ),
         ],
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       );
      },
    );
  }

  Future<void> showRequestSeriesDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Request a racing series',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          content: SizedBox(
            height: 100,
            width: 300,
            child: TextFormField(
              controller: requestRaceNameController,
              decoration: InputDecoration(
                hintText: "Write your request...",
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.40),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor:  Color(0xFFF3F4F6),
              ),
              maxLines: 5,
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              level: "Send a Request",
              onTap: (){
                submitRaceRequest(requestRaceNameController.text );
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }

  Future<void> showRequestReportDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Report',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          content: SizedBox(
            height: 100,
            width: 300,
            child: TextFormField(
              controller: reportMessageController,
              decoration: InputDecoration(
                hintText: "Write your report hare...",
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.40),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor:  Color(0xFFF3F4F6),
              ),
              maxLines: 5,
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              level: "Send a Request",
              onTap: (){
                submitReport(reportMessageController.text);
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }



  final RxList<RaceModel> raceList = <RaceModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  var allRacesList = <RaceAPIModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    fetchAllRaces();
    super.onInit();
  }



  Future<void> fetchAllRaces() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final racesList = await RaceApiService.getAllRaces();
      allRacesList.value = racesList;

    } catch (e) {
      errorMessage.value = 'Failed to load races: $e';
      Get.snackbar(
        'Error',
        'Failed to load races',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }




  // Future<void> fetchRaces() async {
  //   try {
  //     _firestore.collection('race').snapshots().listen((QuerySnapshot snapshot) {
  //       raceList.assignAll(
  //         snapshot.docs.map((doc) => RaceModel.fromFirestore(doc)).toList(),
  //       );
  //
  //     });
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch races: $e');
  //   }
  // }


  Future<void> submitRaceRequest(String raceName) async {
    try {

      String? uid = await SharedPrefHelper.getUid();
      if(uid != null){
        await _firestore.collection('request_race').add({
          'userID': uid,
          'raceName': raceName,
          'timestamp': FieldValue.serverTimestamp(),
        });
        Get.snackbar('Success', 'Race request submitted successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit request: ${e.toString()}');
    }
  }

  Future<void> submitReport(String reportName) async {
    try {

      String? uid = await SharedPrefHelper.getUid();
      if(uid != null){
        await _firestore.collection('report').add({
          'userID': uid,
          'raceName': reportName,
          'timestamp': FieldValue.serverTimestamp(),
        });
        Get.snackbar('Success', 'Race request submitted successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit request: ${e.toString()}');
    }
  }

  void signOut(){
    SharedPrefHelper.clearUid();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    raceList.clear();
    super.onClose();
  }





}

