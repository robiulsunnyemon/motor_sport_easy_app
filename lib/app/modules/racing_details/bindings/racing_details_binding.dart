import 'package:get/get.dart';

import '../controllers/racing_details_controller.dart';

class RacingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RacingDetailsController>(
      () => RacingDetailsController(),
    );
  }
}
