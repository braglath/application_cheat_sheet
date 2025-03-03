import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:application_cheatsheets/app/utils/input_formatters.dart';
import 'package:application_cheatsheets/app/widgets/cancel_add_buttons.dart';
import 'package:application_cheatsheets/app/widgets/custom_text_field.dart';
import 'package:application_cheatsheets/app/widgets/texts/subtitle_text.dart';
import 'package:application_cheatsheets/app/widgets/texts/title_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/add_app_controller.dart';

class AddAppView extends GetView<AddAppController> {
  final List<String> appIds;
  final List<String> appNames;
  AddAppView({required this.appIds, required this.appNames, super.key});

  @override
  final AddAppController controller = Get.put(AddAppController());
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleText(AppString.addAnApplication),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16,
                  children: [
                    // App ID TextField
                    Obx(() => CustomTextField(
                        label: '${AppString.appId} (${AppString.shortName})',
                        hint: AppString.excel,
                        errorText: controller.appIdErrorText.value,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        onChanged: (v) {
                          final appIdExists = appIds
                              .any((e) => e.toLowerCase() == v.toLowerCase());
                          if (appIdExists) {
                            // appId already exists
                            controller.setAppIdError("App Id already exists");
                          } else {
                            controller.setAppIdError(null);
                          }

                          controller.setAppId(v);
                        })),
                    // App Name TextField
                    Obx(() => CustomTextField(
                        isEnabled: controller.appIdErrorText.value == null &&
                            controller.appId.value.isNotEmpty,
                        label: '${AppString.appName} (${AppString.fullName})',
                        hint: AppString.microsoftExcel,
                        errorText: controller.appNameErrorText.value,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'[a-zA-Z ]')), // Allow alphabets and spaces
                          NoConsecutiveSpacesFormatter(),
                        ],
                        onChanged: (v) {
                          final bool appNameExists = appNames
                              .any((e) => e.toLowerCase() == v.toLowerCase());
                          if (appNameExists) {
                            // appName already exists
                            controller
                                .setAppNameError("App Name already exists");
                          } else {
                            controller.setAppNameError(null);
                          }

                          controller.setAppName(v);
                        })),
                    Obx(() {
                      final disableUpload =
                          (controller.appIdErrorText.value != null ||
                                  controller.appNameErrorText.value != null) ||
                              (controller.appId.value.isEmpty ||
                                  controller.appName.value.isEmpty);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.appImageUrl.value.isEmpty
                              ? SubtitleText(
                                  AppString.uploadAppIcon,
                                  style: disableUpload
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.grey)
                                      : null,
                                )
                              : CachedNetworkImage(
                                  width: 25,
                                  height: 25,
                                  imageUrl: controller.appImageUrl.value),
                          CircleAvatar(
                              child: controller.isLoading.isTrue
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: disableUpload
                                          ? null
                                          : () async {
                                              controller.showLoader();
                                              await controller
                                                  .uploadImage()
                                                  .whenComplete(() {
                                                controller.hideLoader();
                                              });
                                            },
                                      icon: Icon(Icons.upload)))
                        ],
                      );
                    })
                  ],
                ),
              ),
              Column(
                children: [
                  const Divider(),
                  // Bottom Buttons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() => CancelAddButtons(
                          onCancel: () {
                            Get.back(); // Close the dialog
                            Get.delete<AddAppController>();
                          },
                          onAdd: controller.appId.value.isEmpty ||
                                  controller.appName.value.isEmpty ||
                                  controller.appImageUrl.value.isEmpty
                              ? null
                              : () {
                                  // Return the values from the controller
                                  Get.back(result: {
                                    'appId': controller.appId.value,
                                    'appName': controller.appName.value,
                                    'appImageUrl': controller.appImageUrl.value,
                                  });
                                },
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
