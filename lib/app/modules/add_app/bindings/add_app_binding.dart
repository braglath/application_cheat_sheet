import 'package:get/get.dart';

import '../controllers/add_app_controller.dart';

class AddAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAppController>(
      () => AddAppController(),
    );
  }
}
