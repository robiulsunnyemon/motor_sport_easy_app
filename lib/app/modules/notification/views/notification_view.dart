import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_appbar_title.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 120, title: const CustomAppbarTitle()),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }

        final response = controller.notifications;
        if (response.isEmpty) {
          return const Center(child: Text('You have no notifications'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: response.length,
          itemBuilder: (context, index) {
            final notification = response[index];
            String formatted = DateFormat('dd/MM/yyyy HH:mm').format(notification.createdAt.toLocal());
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(notification.notificationTitle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.notificationBody),
                    Text(formatted),
                  ],
                ),

              ),
            );

          },
        );
      }),
    );
  }
}
