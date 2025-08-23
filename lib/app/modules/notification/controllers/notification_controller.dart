import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/model/notification_model/notification_model.dart';

class NotificationController extends GetxController {

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  Future<void> fetchNotifications() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('notify')
          .orderBy('createdAt', descending: true)
          .get();

      final List<NotificationModel> fetchedNotifications = querySnapshot.docs
          .map((doc) => NotificationModel.fromSnapshot(doc))
          .toList();

      notifications.assignAll(fetchedNotifications);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch notifications: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchNotifications();
    super.onInit();
  }

}
