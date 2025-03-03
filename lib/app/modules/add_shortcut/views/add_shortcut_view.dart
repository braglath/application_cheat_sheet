import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:application_cheatsheets/app/data/models/shortcuts_model.dart';
import 'package:application_cheatsheets/app/widgets/app_logo_image_small.dart';
import 'package:application_cheatsheets/app/widgets/cancel_add_buttons.dart';
import 'package:application_cheatsheets/app/widgets/custom_text_field.dart';
import 'package:application_cheatsheets/app/widgets/keyboard_text_field.dart';
import 'package:application_cheatsheets/app/widgets/texts/subtitle_text.dart';
import 'package:application_cheatsheets/app/widgets/texts/title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_shortcut_controller.dart';

class AddShortcutView extends GetView<AddShortcutController> {
  final String appName;
  final String appImgUrl;

  final int totalShortcuts; // used to crate the ID
  const AddShortcutView(
      {required this.appName,
      required this.appImgUrl,
      required this.totalShortcuts,
      super.key});

  bool _validateKeyBindings(int keyCount, List<String> keys) {
    for (int i = 0; i < keyCount; i++) {
      if (keys[i].isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddShortcutController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.all(16.0),
        // height: MediaQuery.of(context).size.height * 1.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            TitleText(AppString.addAShortcut),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(appName), AppLogoImageSmall(url: appImgUrl)],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      // Use a scrollable view for the main content
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            label: AppString.title,
                            hint: AppString.saveNewWorkbook,
                            onChanged: controller.setAppTitle,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxlines: 5,
                            label: AppString.description,
                            hint: AppString.thisIsToSaveAFreshNewWorkbook,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            onChanged: controller.setAppDesc,
                          ),
                          SizedBox(height: 24),
                          KeyBindings(),
                        ],
                      ),
                    ),
                  ),
                  // Spacer to push buttons to the bottom
                  Obx(() {
                    bool canAdd() {
                      // Check if app title or description is empty
                      if (controller.appTitle.value.isEmpty ||
                          controller.appDesc.value.isEmpty) {
                        return false;
                      }

                      // Validate key bindings based on key binding count
                      if (controller.keyBindingCount.value == 1) {
                        return _validateKeyBindings(
                            controller.keyCount1.value, [
                          controller.keyBinding1.value,
                          controller.keyBinding2.value,
                          controller.keyBinding3.value,
                        ]);
                      } else {
                        bool keyBindingsValid =
                            _validateKeyBindings(controller.keyCount1.value, [
                          controller.keyBinding1.value,
                          controller.keyBinding2.value,
                          controller.keyBinding3.value,
                        ]);

                        bool keyCombinationsValid =
                            _validateKeyBindings(controller.keyCount2.value, [
                          controller.keyCombination1.value,
                          controller.keyCombination2.value,
                          controller.keyCombination3.value,
                        ]);

                        return keyBindingsValid && keyCombinationsValid;
                      }
                    }

                    return CancelAddButtons(
                      onCancel: () => Navigator.of(context).pop(),
                      onAdd: !canAdd()
                          ? null
                          : () {
                              controller.setFinalKeyBinding();
                              controller.setFinalKeyCombination();

                              final shortcut = ShortcutsModel(
                                id: totalShortcuts + 1,
                                title: controller.appTitle.value,
                                description: controller.appDesc.value,
                                keyBinding: controller.finalKeyBindings.value,
                                keyCombination:
                                    controller.finalKeyCombination.value,
                                dateAdded: DateTime.now(),
                              );

                              print("new shortcut: ${shortcut.toJson()}");

                              Navigator.of(context).pop(shortcut);
                            },
                    );
                  }),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class KeyBindings extends StatelessWidget {
  const KeyBindings({super.key});

  AddShortcutController get controller =>
      GetInstance().find<AddShortcutController>();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          KeyBindingTitle(),
          Obx(() => ListView.separated(
              shrinkWrap: true,
              itemCount: controller.keyBindingCount.value,
              separatorBuilder: (ctx, i) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: TitleText("+")),
                  ),
              itemBuilder: (ctx, index) => KeyCombinationRow(index))),
        ],
      );
}

class KeyBindingTitle extends StatelessWidget {
  const KeyBindingTitle({super.key});

  AddShortcutController get controller =>
      GetInstance().find<AddShortcutController>();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SubtitleText(AppString.keyBindings),
          ),
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Obx(() => CircleAvatar(
                  backgroundColor: controller.keyBindingCount.value == 1
                      ? null
                      : Colors.redAccent.withOpacity(0.3),
                  child: IconButton(
                      onPressed: () {
                        if (controller.keyBindingCount.value == 1) {
                          controller.setKeyBindingCount(2);
                        } else {
                          controller.setKeyBindingCount(1);
                        }
                      },
                      icon: Icon(controller.keyBindingCount.value == 1
                          ? Icons.add
                          : Icons.remove)),
                )),
          )
        ],
      );
}

class KeyCombinationRow extends StatefulWidget {
  final int index;

  const KeyCombinationRow(this.index, {super.key});

  @override
  State<KeyCombinationRow> createState() => _KeyCombinationRowState();
}

class _KeyCombinationRowState extends State<KeyCombinationRow> {
  AddShortcutController get controller =>
      GetInstance().find<AddShortcutController>();

  // Helper method for adding a key
  void _addKeyBinding() {
    if (widget.index == 0 && controller.keyCount1.value < 3) {
      controller.setKeyCount1(controller.keyCount1.value + 1);
    } else if (widget.index == 1 && controller.keyCount2.value < 3) {
      controller.setKeyCount2(controller.keyCount2.value + 1);
    }
  }

  // Helper method for removing a key
  void _removeKeyBinding() {
    if (widget.index == 0 && controller.keyCount1.value > 1) {
      controller.setKeyCount1(controller.keyCount1.value - 1, isRemoving: true);
    } else if (widget.index == 1 && controller.keyCount2.value > 1) {
      controller.setKeyCount2(controller.keyCount2.value - 1, isRemoving: true);
    }
    // if (controller.keyCount2.value == 1) {
    //   controller.setKeyBindingCount(1);
    // }

    // if icon is showing then we allow to remove the first field
    if (widget.index == 0 &&
        controller.keyCount1.value == 1 &&
        controller.keyBinding1.value.isNotEmpty) {
      controller.setKeyBinding1('');
    }

    if (widget.index == 1 &&
        controller.keyCount2.value == 1 &&
        controller.keyCombination1.value.isNotEmpty) {
      controller.setKeyCombination1('');
    }
  }

  // Helper widget for the add/remove buttons
  Widget _buildActionButton({
    required bool isAddButton,
    required VoidCallback onPressed,
    required bool isVisible,
  }) {
    if (!isVisible) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(left: isAddButton ? 0 : 16.0),
      child: CircleAvatar(
        backgroundColor: isAddButton ? null : Colors.redAccent.withOpacity(0.3),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(isAddButton ? Icons.add : Icons.remove),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isKeyCount1Full = controller.keyCount1.value == 3;
      final isKeyCount2Full = controller.keyCount2.value == 3;
      final isKeyCount1Min = controller.keyCount1.value == 1 &&
          controller.keyBinding1.value.isEmpty;
      final isKeyCount2Min = controller.keyCount2.value == 1 &&
          controller.keyCombination1.value.isEmpty;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // List of text fields for key combinations
          SizedBox(
            height: 70.0,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.index == 0
                  ? controller.keyCount1.value
                  : controller.keyCount2.value,
              separatorBuilder: (ctx, i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: TitleText("+")),
              ),
              itemBuilder: (context, i) {
                print("index: ${widget.index}\ni: $i");

                // Method to return the appropriate icon based on the key value
                IconData getIconForKey(String keyValue) {
                  switch (keyValue) {
                    case 'Down':
                      return Icons.arrow_downward;
                    case 'Left':
                      return Icons.chevron_left;
                    case 'Right':
                      return Icons.chevron_right;
                    default:
                      return Icons.help; // Fallback icon if something is wrong
                  }
                }

                final onChanged = widget.index == 0
                    ? i == 0
                        ? controller.setKeyBinding1
                        : i == 1
                            ? controller.setKeyBinding2
                            : controller.setKeyBinding3
                    : i == 0
                        ? controller.setKeyCombination1
                        : i == 1
                            ? controller.setKeyCombination2
                            : controller.setKeyCombination3;

                // Get the key value based on the index and check if it's a predefined value
                final keyValue = widget.index == 0
                    ? i == 0
                        ? controller.keyBinding1.value
                        : i == 1
                            ? controller.keyBinding2.value
                            : controller.keyBinding3.value
                    : i == 0
                        ? controller.keyCombination1.value
                        : i == 1
                            ? controller.keyCombination2.value
                            : controller.keyCombination3.value;

                // Check if the value matches the predefined keys
                if (['Up', 'Down', 'Left', 'Right'].contains(keyValue)) {
                  // Show the icon for predefined values
                  return Icon(
                    getIconForKey(
                        keyValue), // Use a method to get the appropriate icon
                    size: 30,
                  );
                } else if ([
                  'Shift',
                  'Ctrl',
                  'Alt',
                ].contains(keyValue)) {
                  return Center(child: TitleText(keyValue));
                } else {
                  // Otherwise, show the KeyboardTextField
                  return KeyboardTextField(
                    onChanged: onChanged,
                  );
                }
              },
            ),
          ),
          Row(
            children: [
              // Add button, visible when there are less than 3 key bindings
              _buildActionButton(
                isAddButton: true,
                onPressed: _addKeyBinding,
                isVisible: !(widget.index == 0 && isKeyCount1Full) &&
                    !(widget.index == 1 && isKeyCount2Full),
              ),
              // Spacing between buttons when necessary
              _buildActionButton(
                isAddButton: false,
                onPressed: _removeKeyBinding,
                isVisible: !(widget.index == 0 && isKeyCount1Min) &&
                    !(widget.index == 1 && isKeyCount2Min),
              ),
            ],
          ),
        ],
      );
    });
  }
}
