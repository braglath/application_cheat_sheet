import 'package:get/get.dart';

import '../controllers/add_shortcut_controller.dart';

class AddShortcutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddShortcutController>(
      () => AddShortcutController(),
    );
  }
}
