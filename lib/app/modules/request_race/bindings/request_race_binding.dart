import 'package:get/get.dart';

import '../controllers/request_race_controller.dart';

class RequestRaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestRaceController>(
      () => RequestRaceController(),
    );
  }
}
