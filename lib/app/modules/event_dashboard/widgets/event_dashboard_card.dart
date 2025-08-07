import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDashboardCard extends StatelessWidget {
  final String eventName;
  final String location;
  final String time;
  final String date;
  final String sponsor;
  final VoidCallback onTap;
  final int index;
  final bool isHeader;

  const EventDashboardCard({
    super.key,
    required this.eventName,
    required this.location,
    required this.time,
    required this.date,
    required this.sponsor,
    required this.onTap,
    required this.index,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 80,
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
                width: screenWidth>700? screenWidth*0.104:80,
                child: Text(
                  eventName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>700?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>700? screenWidth*0.104:65,
                child: Text(
                  location,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>700?19:14,
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
                    fontSize: screenWidth>700?19:14,
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
                  date,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>700?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>700? screenWidth*0.104:70,
                child: Row(
                  children: [
                    Text(
                      sponsor,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth>700?19:14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    isHeader?SizedBox():screenWidth>700?SizedBox(width: screenWidth*0.0083,):SizedBox(width: 8,),
                    isHeader?SizedBox():screenWidth>700?SvgPicture.asset("svg/verticaldot.svg",):SvgPicture.asset("assets/svg/verticaldot.svg",)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

}
