import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbar_title.dart';
import '../../widgets/custom_event_card.dart';
import '../controllers/racing_details_controller.dart';

class RacingDetailsView extends GetView<RacingDetailsController> {
  const RacingDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 120,
        title: CustomAppbarTitle(),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                      child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'MotoGP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Upcoming Events',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      controller.showMyDialog(context);
                    },
                    child: CustomEventCard(
                      eventDate: DateTime.now(),
                      eventLocation: "Austria",
                      tvName: "TV Name",
                    ),
                  ),
                );
              },
          )

        ],
      ),
    );
  }
}
