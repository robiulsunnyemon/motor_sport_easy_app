import 'package:get/get.dart';

import '../controllers/report_admin_controller.dart';

class ReportAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportAdminController>(
      () => ReportAdminController(),
    );
  }
}
