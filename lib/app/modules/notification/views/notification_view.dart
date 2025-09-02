import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbar_title.dart';
import '../widgets/custom_notification_card.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 120, title: const CustomAppbarTitle()),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.freshNotifications();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${controller.errorMessage.value}'));
          }

          final response = controller.notificationResponse.value;
          if (response == null || response.notifications.isEmpty) {
            return const Center(child: Text('You have no notifications'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: response.notifications.length,
            itemBuilder: (context, index) {
              final notification = response.notifications[index];

              if (!notification.sent) return const SizedBox.shrink();


              if(notification.type=="admin_broadcast"){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomNotificationCard(
                    notificationTitle: notification.title ??" ",
                    notificationBody: notification.message ??" ",
                    // notificationDateTime:notification.timestamp ?? notification.notificationTime,
                  ),
                );
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomNotificationCard(
                    notificationTitle: notification.notificationMessage?.notification.title ??"",
                    notificationBody: notification.notificationMessage?.notification.body ??" ",
                    // notificationDateTime: notification.data!.timestamp != null
                    //     ? DateTime.parse(notification.data!.timestamp!)
                    //     : DateTime.now(),
                  ),
                );
              }


            },
          );
        }),
      ),
    );
  }
}
