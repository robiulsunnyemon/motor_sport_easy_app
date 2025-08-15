import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/modules/race_admin/controllers/race_admin_controller.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';

import '../../widgets/custom_elevated_button.dart';

class RaceDashboardCard extends StatelessWidget {
  final String racingName;
  final String sponsorLogo;
  final int index;
  final bool isHeader;
  final String raceId;

  const RaceDashboardCard({
    super.key,
    required this.racingName,
    required this.index,
    required this.sponsorLogo,
    this.isHeader = false,
    required this.raceId,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    return Container(
      width: double.infinity,
      height: screenWidth > 600 ? 60 : 50,
      padding: EdgeInsets.symmetric(horizontal: screenWidth > 700 ? 12 : 4),
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
          Expanded(
            child: SizedBox(
              width: screenWidth > 600 ? screenWidth * 0.104 : 80,
              child: Center(
                child: Text(
                  racingName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth > 600 ? 19 : 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: screenWidth > 600 ? screenWidth * 0.104 : 40,
              child: Center(
                child: isHeader
                    ? Text(
                        "Logo",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth > 600 ? 19 : 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Image.network(sponsorLogo, height: 40, width: 40),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: screenWidth > 600 ? screenWidth * 0.104 : 30,
              child: Center(
                child: isHeader
                    ? Icon(Icons.more_vert)
                    : InkWell(
                    onTap: (){
                      showRequestDialog(context,raceId);
                    },

                    child: Icon(Icons.more_vert)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> showRequestDialog(BuildContext context, String raceId) async {
    final raceAdminController = Get.find<RaceAdminController>();
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
              level: "Delete Series",
              onTap: (){
                raceAdminController.deleteRace(raceId);
                Get.back();
              },
            ),
            SizedBox(height: 10,),
            CustomElevatedButton(
              level: "All Event",
              onTap:(){
                Get.offAndToNamed("${Routes.SINGLE_RACE_EVENT_DASHBOARD}/$raceId");
              },
              isBackgroundWhite: true,
              isBorderRed: true,
            ),
            SizedBox(height: 10,),
            CustomElevatedButton(
              level: "Update Series",
              onTap: (){
                Get.toNamed("${Routes.UPDATE_RACE_DASHBOARD}/$raceId");
                },
            ),

          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }


}
