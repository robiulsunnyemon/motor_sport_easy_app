import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';
import '../../widgets/custom_appbar_title.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_racing_card_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 120, title: CustomAppbarTitle()),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select racing series',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
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
            if(controller.events.isEmpty){
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else{
              return SliverList.builder(
                  itemCount: controller.events.length,
                  itemBuilder: (context, index) {
                    final event = controller.events[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 7),
                      child: CustomRacingCardButton(
                        racingName: event.title,
                        sponsorName:  event.sponsor,
                        sponsorLogo: event.logoUrl,
                        onTap: (){
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
