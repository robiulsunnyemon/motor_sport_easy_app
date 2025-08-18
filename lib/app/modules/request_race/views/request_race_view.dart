import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_race_controller.dart';

class RequestRaceView extends GetView<RequestRaceController> {
  const RequestRaceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RequestRaceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RequestRaceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
