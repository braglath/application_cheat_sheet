import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:application_cheatsheets/app/modules/shortcuts/controllers/shortcuts_controller.dart';
import 'package:application_cheatsheets/app/modules/shortcuts/views/shortcuts_view.dart';
import 'package:application_cheatsheets/app/widgets/app_logo_image_small.dart';
import 'package:application_cheatsheets/app/widgets/texts/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_page_controller.dart';

class AppPageView extends GetView<AppPageController> {
  const AppPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Obx(() => Text(controller.app.value?.name ?? '')),
            actions: [
              Obx(() {
                return Hero(
                  tag: controller.app.value?.id ?? '',
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 1.0),
                        child: AppLogoImageSmall(
                            url: controller.app.value?.url ?? '')),
                  ),
                );
              }),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: AppString.shortcuts,
                  icon: Icon(Icons.shortcut_outlined),
                ),
                Tab(
                  text: AppString.notes,
                  icon: Icon(Icons.notes_outlined),
                ),
              ],
            ), //TabBar,
          ),
          body: TabBarView(
            children: [
              GetBuilder<ShortcutsController>(
                init: ShortcutsController(controller.app.value),
                builder: (controller) => ShortcutsView(),
              ),
              Center(child: SubtitleText("No Notes added yet"))
            ],
          ), // TabBarV  SizedBox.shrink()),
        ));
  }
}
