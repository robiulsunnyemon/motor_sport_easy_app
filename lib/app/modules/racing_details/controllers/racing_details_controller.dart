import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/model/event_model/event_model.dart';
import '../widgets/set_notification_alert_dialog.dart';

class RacingDetailsController extends GetxController {
  RxInt setHour=1.obs;
  RxBool is8Hour=false.obs;
  RxBool is3Hour=false.obs;
  RxBool is6Hour=false.obs;


  void increaseSetHour(){
    setHour.value++;
    update();
  }
  void decreaseSetHour(){
   if(setHour.value>1){
     setHour.value--;
     update();
   }
  }
  void set8Hour(){
    if(is8Hour.value==false){
      is8Hour.value=true;
    }else{
      is8Hour.value=false;
    }
    update();
  }
  void set3Hour(){
    if(is3Hour.value==false){
      is3Hour.value=true;
    }else{
      is3Hour.value=false;
    }
    update();
  }
  void set6Hour(){
    if(is6Hour.value==false){
      is6Hour.value=true;
    }else{
      is6Hour.value=false;
    }
    update();
  }

  Future<void> showMyDialog({required BuildContext context,required String eventId}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SetNotificationAlertDialog(
          eventId: eventId,
          raceId: '',
        );
      },
    );
  }



  final events = <EventModel>[].obs;
  final isLoading = false.obs;



  Future<void> getEventsByRaceId(String raceId) async {
    try {
      isLoading(true);
      events.clear();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('race')
          .doc(raceId)
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();


      events.assignAll(
          querySnapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList()
      );

    } catch (e) {
      Get.snackbar('Error', 'Failed to load events: $e');
    } finally {
      isLoading(false);
    }
  }




  Future<void> saveNotificationPreferences({required String eventId,
  required  List<int> times,
  required  BuildContext context,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Not logged in. Please log in first'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show loading indicator
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(width: 10),
              Text('Saving preferences...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Failed to get notification token'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('user_event_subscriptions')
          .doc('$userId-$eventId')
          .set({
        'userId': userId,
        'eventId': eventId,
        'notificationTimes': times,
        'fcmTokens': FieldValue.arrayUnion([fcmToken]),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Show success message
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Notification preferences saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

    } on FirebaseException catch (e) {
      // Handle Firebase specific errors
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Firebase error: ${e.message ?? 'Unknown error'}'),
          backgroundColor: Colors.red,
        ),
      );
      print('Firebase error: ${e.stackTrace}');

    } on PlatformException catch (e) {
      // Handle platform specific errors (FCM token related)
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Device error: ${e.message ?? 'Unknown error'}'),
          backgroundColor: Colors.red,
        ),
      );


    } catch (e) {
      // Handle all other errors
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print('General error: $e');
    }
  }
}
