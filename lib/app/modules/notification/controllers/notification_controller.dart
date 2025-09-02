import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/model/notification/notification_model.dart';
import '../../../data/model/notification_model/notification_model.dart';
import '../../../shared_pref_helper/shared_pref_helper.dart';

class NotificationController extends GetxController {

  final RxList<Notification> notifications = <Notification>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var notificationResponse = Rxn<NotificationResponse>();


  Future<NotificationResponse> getUserNotifications(String userId) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://motogp.mtscorporate.com/api/notifications/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      print("update notification");
      print(response.statusCode);
      print(response.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        notificationResponse.value = NotificationResponse.fromJson(data);
        return NotificationResponse.fromJson(data);

      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value =e.toString();
      throw Exception('Failed to load notifications: $e');
    }
  }



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    final uid= await SharedPrefHelper.getUid();
    getUserNotifications(uid??"");
    super.onInit();
  }


  Future<void> freshNotifications()async{
    final uid= await SharedPrefHelper.getUid();
    getUserNotifications(uid??"");
  }

}
