import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/request_admin_controller.dart';

class RequestAdminView extends GetView<RequestAdminController> {
  const RequestAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget buildSliverList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final request = controller.raceRequests[index];
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
          childCount: controller.raceRequests.length,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: screenWidth < 600
            ? Obx(() {
          if (controller.raceRequests.isEmpty) {
            return const Center(child: Text('No requests found'));
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                floating: true,
                pinned: true,
                snap: false,
                backgroundColor: const Color(0xFFDC2626),
                flexibleSpace: const FlexibleSpaceBar(
                  title:Text('Race Requests',style: TextStyle(color: Colors.white),),
                ),
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
            ),
            child: Obx(() {
              if (controller.raceRequests.isEmpty) {
                return const Center(child: Text('No requests found'));
              }
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
                    floating: true,
                    pinned: true,
                    snap: false,
                    backgroundColor: const Color(0xFFDC2626),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('Race Requests',style: TextStyle(color: Colors.white),),
                    ),
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
