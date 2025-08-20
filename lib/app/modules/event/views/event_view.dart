import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/custom_appbar_title.dart';
import '../../widgets/custom_event_card.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: screenHeight*120/752,
        title: CustomAppbarTitle(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*8.0/360,vertical: screenWidth*15/360),
              child: Text(
                'Upcoming Events',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth*24/360,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){

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
