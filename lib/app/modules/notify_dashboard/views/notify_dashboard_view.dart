import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_elevated_button.dart';
import '../controllers/notify_dashboard_controller.dart';

class NotifyDashboardView extends GetView<NotifyDashboardController> {
  const NotifyDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: screenWidth<600? Color(0xFFF3F3F3):Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 900,
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(color: const Color(0xFFF3F3F3)),
            child: screenWidth > 600
                ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 40,
              children: [
                Row(
                  children: [
                    Text(
                      'Send Notification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.dashboard,color:  Color(0xFFDC2626)))
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 32,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 24,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  SizedBox(
                                    width: 390,
                                    child: Text(
                                      'Message',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: controller
                                          .notificationController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'This Field is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                        'write a notification body..',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 295,
                  child: CustomElevatedButton(
                    onTap: () {
                        controller.createRace(context: context);
                    },
                    level: "Send",
                  ),
                ),
              ],
            )
                : ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Send notification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            SizedBox(
                              width: 390,
                              child: Text(
                                'Message',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                controller:
                                controller.notificationController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This Field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'write notification message..',
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),

                SizedBox(height: 24),
                CustomElevatedButton(
                  onTap: () {
                      //controller.createRace(context: context);
                      controller.createNotification();
                  },
                  level: "Send",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
