import 'package:get/get.dart';

import '../controllers/shortcuts_controller.dart';

class ShortcutsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortcutsController>(
      () => ShortcutsController(),
    );
  }
}
