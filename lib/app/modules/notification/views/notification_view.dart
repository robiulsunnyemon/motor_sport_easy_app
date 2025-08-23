import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbar_title.dart';
import '../widgets/custom_notification_card.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {

    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(

        toolbarHeight: screenHeight*120/752,
        title: CustomAppbarTitle(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth*24/360,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
         Obx((){
           if (controller.notifications.isEmpty) {
             return SliverToBoxAdapter(
               child: Center(
                 child: Text('No notifications available.'),
               ),
             );
           }else{
            return SliverList.builder(
               itemCount: controller.notifications.length,
               itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: CustomNotificationCard(
                     notificationTitle: controller.notifications[index].title,
                     notificationDateTime: controller.notifications[index].createdAt ??DateTime.now(),
                   ),
                 );
               },
             );
           }
         })

        ],
      ),
    );
  }
}
