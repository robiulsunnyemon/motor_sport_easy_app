import 'package:get/get.dart';

import '../controllers/race_admin_controller.dart';

class RaceAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RaceAdminController>(
      () => RaceAdminController(),
    );
  }
}
