import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';
import '../../widgets/custom_elevated_button.dart';
import '../controllers/single_race_event_dashboard_controller.dart';

class SingleRaceEventDashboardCard extends StatelessWidget {
  final String broadcastChannel;
  final String location;
  final String time;
  final String date;
  final String sponsor;
  final VoidCallback onTap;
  final int index;
  final bool isHeader;
  final String eventId;

  const SingleRaceEventDashboardCard({
    super.key,
    required this.broadcastChannel,
    required this.location,
    required this.time,
    required this.date,
    required this.sponsor,
    required this.onTap,
    required this.index,
    this.isHeader = false,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: screenWidth>600?80:60,
          padding: EdgeInsets.symmetric(horizontal: screenWidth>700 ?12:4),
          decoration: BoxDecoration(
            color: isHeader
                ? Color(0xFFFFD4D4)
                : index.isEven
                ? Color(0xFFF5F5F5)
                : Color(0xFFF3F3F3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:80,
                child: Text(
                  broadcastChannel,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:65,
                child: Text(
                  location,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>700? screenWidth*0.104:50,
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:50,
                child: Text(
                  date,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:70,
                child: isHeader? Icon(Icons.more_vert):InkWell( onTap:(){
                  showRequestDialog(context,eventId);
                },child:  Icon(Icons.more_vert),),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> showRequestDialog(BuildContext context,String eventId) async {

    final singleRaceEventDashboardController = Get.find<SingleRaceEventDashboardController>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'What is you want to do?',
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
              level: "Delete Event",
              onTap: (){
                singleRaceEventDashboardController.deleteEvent(eventId);
                Get.back();
              },
            ),
            SizedBox(height: 10,),
            CustomElevatedButton(
              level: "Update Event",
              onTap:(){
                Get.toNamed(
                    "${Routes.EDIT_EVENT_DASHBOARD}/${singleRaceEventDashboardController.raceID}/$eventId"
                );
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

}