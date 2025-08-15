import 'package:flutter/material.dart';

class EventDashboardCard extends StatelessWidget {
  final String broadcastChannel;
  final String location;
  final String time;
  final String date;
  final String sponsor;
  final VoidCallback onTap;
  final int index;
  final bool isHeader;

  const EventDashboardCard({
    super.key,
    required this.broadcastChannel,
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
          height: screenWidth>600?80:60,
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
                width: screenWidth>600? screenWidth*0.104:80,
                child: Text(
                  broadcastChannel,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:65,
                child: Text(
                  location,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
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
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:50,
                child: Text(
                  date,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth>600?19:14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth>600? screenWidth*0.104:70,
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }


}
