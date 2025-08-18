import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_admin_controller.dart';

class ReportAdminView extends GetView<ReportAdminController> {
  const ReportAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Race Requests',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchRaceReport,
          )
        ],
      ),
      body: Obx(() {
        if (controller.reportRaces.isEmpty) {
          return Center(child: Text('No requests found'));
        }

        return ListView.builder(
          itemCount: controller.reportRaces.length,
          itemBuilder: (context, index) {
            final request = controller.reportRaces[index];
            return Card(
              color: Colors.white,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(request['raceName'] ?? 'No Name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID: ${request['userID']}'),
                    if (request['timestamp'] != null)
                      Text('Date: ${request['timestamp'].toDate().toString()}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
