import 'package:get/get.dart';

import '../controllers/request_admin_controller.dart';

class RequestAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestAdminController>(
      () => RequestAdminController(),
    );
  }
}
