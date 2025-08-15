import 'package:get/get.dart';

import '../controllers/create_race_admin_controller.dart';

class CreateRaceAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRaceAdminController>(
      () => CreateRaceAdminController(),
    );
  }
}
