import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/report_admin_controller.dart';

class ReportAdminView extends GetView<ReportAdminController> {
  const ReportAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget buildSliverList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final request = controller.reportRaces[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(request['raceName'] ?? 'No Name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID: ${request['userID']}'),
                    if (request['timestamp'] != null)
                      Text(
                        'Date: ${request['timestamp'].toDate().toString()}',
                      ),
                  ],
                ),
              ),
            );
          },
          childCount: controller.reportRaces.length,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: screenWidth < 600
            ? Obx(() {
          if (controller.reportRaces.isEmpty) {
            return const Center(child: Text('No requests found'));
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                floating: true,
                pinned: true,
                backgroundColor: const Color(0xFFDC2626),
                flexibleSpace: const FlexibleSpaceBar(
                  title:Text('Race Reports',style: TextStyle(color: Colors.white),),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: controller.fetchRaceReport,
                  ),
                ],
              ),
              buildSliverList(),
            ],
          );
        })
            : Center(
          child: Container(
            width: 800,
            height: 800,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Obx(() {
              if (controller.reportRaces.isEmpty) {
                return const Center(child: Text('No requests found'));
              }
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
                    floating: true,
                    pinned: true,
                    backgroundColor: const Color(0xFFDC2626),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('Race Reports',style: TextStyle(color: Colors.white),),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        onPressed: controller.fetchRaceReport,
                      ),
                    ],
                  ),
                  buildSliverList(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
