import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_appbar_title.dart';
import '../../widgets/custom_event_card.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
              child: Text(
                'Upcoming Events',
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
