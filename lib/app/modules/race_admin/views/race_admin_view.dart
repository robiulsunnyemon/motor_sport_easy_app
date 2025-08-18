import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:motor_sport_easy/app/modules/widgets/custom_elevated_button.dart';

import '../../../routes/app_pages.dart';
import '../controllers/race_admin_controller.dart';
import '../widgets/race_create_button.dart';
import '../widgets/race_dashboard_card.dart';

class RaceAdminView extends GetView<RaceAdminController> {
  const RaceAdminView({super.key});
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
                  width: screenWidth > 700
                      ? screenWidth * 0.789
                      : double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: screenWidth < 600
                        ? Column(
                          children: [
                            CustomElevatedButton(onTap: (){
                              Get.toNamed(Routes.REQUEST_ADMIN);
                            }, level: "Request Race"),
                            SizedBox(height: 10),
                            CustomElevatedButton(onTap: (){
                              Get.toNamed(Routes.REPORT_ADMIN);
                            }, level: "Report"),
                            SizedBox(height: 10),
                            RaceCreateButton(
                               onTap: () {
                                 Get.toNamed(Routes.CREATE_RACE_ADMIN);
                               },
                             level: "Create a Race",
                                                           ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'All Racing',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                      onTap: () {
                                        Get.toNamed(Routes.REPORT_ADMIN);
                                      },
                                      level: "All Report",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CustomElevatedButton(
                                      onTap: () {
                                        Get.toNamed(Routes.REQUEST_ADMIN);
                                      },
                                      level: "Request Race",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: RaceCreateButton(
                                      onTap: () {
                                      Get.toNamed(Routes.CREATE_RACE_ADMIN);
                                      },
                                      level: "Create a Race",
                                      ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'All Racing',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 10),
                screenWidth > 600
                    ? Column(
                        children: [
                          SizedBox(
                            width: screenWidth > 700
                                ? screenWidth * 0.789
                                : double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth > 700 ? 12 : 2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: RaceDashboardCard(
                                  racingName: "Racing",
                                  sponsorLogo: '',
                                  raceId: "",
                                  index: 1,
                                  isHeader: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenWidth > 700 ? 700 : 300,
                            width: screenWidth > 700
                                ? screenWidth * 0.789
                                : double.infinity,
                            child: Obx(()=>ListView.builder(
                              itemCount: controller.raceList.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                final race=controller.raceList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth > 700 ? 12 : 2,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: RaceDashboardCard(
                                      racingName: race.title,
                                      sponsorLogo: race.logoUrl,
                                      raceId: race.id,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),)
                          ),
                        ],
                      )
                    : Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.3),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth > 700
                                  ? screenWidth * 0.789
                                  : double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth > 700 ? 12 : 2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: RaceDashboardCard(
                                    racingName: "Race",
                                    sponsorLogo: '',
                                    raceId: "",
                                    index: 1,
                                    isHeader: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenWidth > 700 ? 700 : 300,
                              width: screenWidth > 700
                                  ? screenWidth * 0.789
                                  : double.infinity,
                              child: Obx(()=>ListView.builder(
                                itemCount: controller.raceList.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final race=controller.raceList[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth > 700 ? 12 : 2,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: RaceDashboardCard(
                                        racingName: race.title,
                                        sponsorLogo: race.logoUrl,
                                        raceId: race.id,
                                        index: index,
                                      ),
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
