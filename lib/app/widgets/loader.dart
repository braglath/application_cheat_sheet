import 'package:application_cheatsheets/app/widgets/screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader<T extends GetxController> extends StatelessWidget {
  const Loader({super.key});

  T get controller => Get.find<T>();

  @override
  Widget build(BuildContext context) => Obx(() {
        final dynamic isLoading = controller as dynamic;
        return isLoading.isLoading.value
            ? ScreenLoader()
            : const SizedBox.shrink(); // Hide loader when not loading
      });
}
