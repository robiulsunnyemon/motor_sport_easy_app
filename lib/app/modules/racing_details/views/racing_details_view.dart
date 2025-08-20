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
          Obx(()=>SliverList.builder(
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    controller.showMyDialog(
                        context: context,
                        eventId: controller.events[index].id,
                        eventName: controller.events[index].location,
                        eventDate: controller.events[index].fullDateTime,
                        hour: 1
                    );
                  },
                  child: CustomEventCard(
                    eventDate: controller.events[index].fullDateTime,
                    eventLocation: controller.events[index].location,
                    tvName: controller.events[index].broadcastChannel,
                  ),
                ),
              );
            },
          ))

        ],
      ),
    );
  }



}
