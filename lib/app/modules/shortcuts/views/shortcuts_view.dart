import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:application_cheatsheets/app/data/models/shortcuts_model.dart';
import 'package:application_cheatsheets/app/modules/add_shortcut/controllers/add_shortcut_controller.dart';
import 'package:application_cheatsheets/app/modules/add_shortcut/views/add_shortcut_view.dart';
import 'package:application_cheatsheets/app/utils/app_extensions.dart';
import 'package:application_cheatsheets/app/utils/logger_utils';
import 'package:application_cheatsheets/app/widgets/app_logo_image_small.dart';
import 'package:application_cheatsheets/app/widgets/loader.dart';
import 'package:application_cheatsheets/app/widgets/search_with_fab.dart';
import 'package:application_cheatsheets/app/widgets/text_with_rectangles.dart';
import 'package:application_cheatsheets/app/widgets/texts/small_text.dart';
import 'package:application_cheatsheets/app/widgets/texts/subtitle_text.dart';
import 'package:application_cheatsheets/app/widgets/texts/title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/shortcuts_controller.dart';

class ShortcutsView extends GetView<ShortcutsController> {
  const ShortcutsView({super.key});

  void _showAddShortcutBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allowing customization of height
      builder: (context) => GetBuilder<AddShortcutController>(
        init: AddShortcutController(),
        dispose: (_) => Get.delete<AddShortcutController>(),
        builder: (_) => AddShortcutView(
          appName: controller.app.value?.name ?? '',
          appImgUrl: controller.app.value?.url ?? '',
          totalShortcuts: controller.shortcuts.length, // used to create ID
        ),
      ),
    );

    if (result != null && result is ShortcutsModel) {
      LoggerUtils.i("Received result: ${result.toJson()}");
      // add the shortcut

      await controller.addShortcut(result).whenComplete(
          () => controller.getAllShortcuts(controller.app.value?.id ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // extendBodyBehindAppBar: true,
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(() => controller.shortcuts.isEmpty
                      ? Center(
                          child: SubtitleText(AppString.noShortcutsAddedYet))
                      : ListView.separated(
                          padding: EdgeInsets.only(bottom: 150),
                          shrinkWrap: true,
                          itemCount: controller.shortcuts.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) => ExpansionTile(
                                leading: Text((index + 1).toString()),
                                maintainState: true,
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TitleText(
                                      controller.shortcuts[index].title ?? ''),
                                ),
                                subtitle: Column(
                                  spacing: controller.shortcuts[index]
                                          .keyCombination.isNullOrEmpty
                                      ? 0
                                      : 16,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWithRectangles(
                                        text: controller
                                                .shortcuts[index].keyBinding ??
                                            ''),
                                    controller.shortcuts[index].keyCombination
                                            .isNullOrEmpty
                                        ? SizedBox.shrink()
                                        : TextWithRectangles(
                                            text: controller.shortcuts[index]
                                                    .keyCombination ??
                                                ''),
                                  ],
                                ),
                                childrenPadding: EdgeInsets.only(
                                    left: 16.0,
                                    bottom: 8,
                                    right: 16.0,
                                    top: 8.0),
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4,
                                      children: [
                                        SmallText("${AppString.description}:"),
                                        SubtitleText(controller
                                                .shortcuts[index].description ??
                                            ''),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Like button
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 15,
                                            child: Icon(
                                              Icons.thumb_up,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                16), // Space between the buttons
                                        // Dislike button
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 15,
                                            child: Icon(
                                              Icons.thumb_down,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                  SearchWithFab(
                    onFabPressed: () => _showAddShortcutBottomSheet(context),
                    onTextFieldChanged: (v) {},
                    textLabel: "Search Shortcuts",
                    fabLabel: AppString.addShortcut,
                  )
                ],
              ),
              Loader<ShortcutsController>(),
            ],
          ),
        ));
  }
}
