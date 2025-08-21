import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/modules/event_dashboard/widgets/event_dashboard_card.dart';
import 'package:motor_sport_easy/app/modules/widgets/custom_elevated_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/event_dashboard_controller.dart';

class EventDashboardView extends GetView<EventDashboardController> {
  const EventDashboardView({super.key});
  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth>700?screenWidth*0.789:double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: screenWidth < 500
                        ? Wrap(
                      children: [
                        Text(
                          'All events',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: CustomElevatedButton(
                            onTap: () {
                              Get.toNamed(Routes.RACE_ADMIN);
                            },
                            level: "Dashboard",
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All events',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: CustomElevatedButton(
                            onTap: () {
                              Get.toNamed(Routes.RACE_ADMIN);
                            },
                            level: "Dashboard",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                screenWidth>600?Column(
                  children: [
                    SizedBox(
                      width: screenWidth>700?screenWidth*0.789:double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth > 700 ? 12 : 2,
                        ),
                        child: EventDashboardCard(
                          broadcastChannel: "Channel Name",
                          location: "Location",
                          time: 'Time',
                          date: 'Date',
                          sponsor: "Sponsor",
                          onTap: () {},
                          index: 1,
                          isHeader: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenWidth>700?700:300,
                      width: screenWidth>700?screenWidth*0.789:double.infinity,
                      child: Obx(()=>ListView.builder(
                        itemCount: controller.events.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth > 700 ? 12 : 2,
                            ),
                            child: EventDashboardCard(
                              broadcastChannel: controller.events[index].broadcastChannel,
                              location: controller.events[index].location,
                              time: controller.events[index].fullDateTime.toString(),
                              date: controller.events[index].fullDateTime.toString(),
                              sponsor: controller.events[index].logoUrl,
                              onTap: () {
                                Get.toNamed(Routes.EDIT_EVENT_DASHBOARD);
                              },
                              index: index,
                            ),
                          );
                        },
                      ),)
                    ),
                  ],
                ):Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth>700?screenWidth*0.789:double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth > 700 ? 12 : 2,
                          ),
                          child: EventDashboardCard(
                            broadcastChannel: "Channel",
                            location: "Location",
                            time: 'Time',
                            date: 'Date',
                            sponsor: "Sponsor",
                            onTap: () {},
                            index: 1,
                            isHeader: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth>700?700:300,
                        width: screenWidth>700?screenWidth*0.789:double.infinity,
                        child: Obx(()=> ListView.builder(
                          itemCount: controller.events.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth > 700 ? 12 : 2,
                              ),
                              child: EventDashboardCard(
                                broadcastChannel: controller.events[index].broadcastChannel,
                                location: controller.events[index].location,
                                time: controller.events[index].fullDateTime.toString(),
                                date: controller.events[index].fullDateTime.toString(),
                                sponsor: controller.events[index].logoUrl,
                                onTap: () {
                                  Get.toNamed(Routes.EDIT_EVENT_DASHBOARD);
                                },
                                index: index,
                              ),
                            );
                          },
                        ),)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
