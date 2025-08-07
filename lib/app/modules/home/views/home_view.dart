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
      appBar:AppBar(
        toolbarHeight: 120,
        title: CustomAppbarTitle(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select racing series',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRacingCardButton(
                    onTap: (){
                      Get.toNamed(
                        Routes.RACING_DETAILS,
                        preventDuplicates: true,

                      );
                    },
                    racingName: "Formula E",
                    sponsorLogo: "",
                    sponsorName: "BMW",
                  ),
                );
              },
          )
        ],
      )
    );
  }
}
