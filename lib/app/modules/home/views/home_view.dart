import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';
import '../../racing_details/controllers/racing_details_controller.dart';
import '../../widgets/custom_appbar_title.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_racing_card_button.dart';

class HomeView extends GetView<HomeController> {
   HomeView({super.key});
  final _raceDetailsController =Get.put(RacingDetailsController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(toolbarHeight: screenHeight*120/752, title: CustomAppbarTitle()),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth*.556,
                    child: Text(
                      'Select racing series',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth*24/360,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.showRequestDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: const Color(0x4CF93939),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 2,
                        children: [
                          Icon(Icons.add),
                          Text(
                            'Request',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF3A3A3A),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if(controller.raceList.isEmpty){
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else{
              return SliverList.builder(
                  itemCount: controller.raceList.length,
                  itemBuilder: (context, index) {
                    final race = controller.raceList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 7),
                      child: CustomRacingCardButton(
                        racingName: race.title,
                        sponsorLogo: race.logoUrl,
                        onTap: (){
                          Get.toNamed(Routes.RACING_DETAILS);
                          _raceDetailsController.getEventsByRaceId(controller.raceList[index].id);
                        },
                      ),
                    );

                  }
              );
            }
          }),
        ],
      ),
    );
  }
}
