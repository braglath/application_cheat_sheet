import 'package:application_cheatsheets/app/widgets/keyboard_options_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardTextField extends StatefulWidget {
  final void Function(String)? onChanged;

  const KeyboardTextField({super.key, required this.onChanged});

  @override
  State<KeyboardTextField> createState() => _KeyboardTextFieldState();
}

class _KeyboardTextFieldState extends State<KeyboardTextField> {
  final FocusNode _nodeText = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      keyboardBarElevation: 8,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText,
          displayArrows: false,
          displayDoneButton: false,
          toolbarButtons: [
            (node) => KeyboardOptionsButton(
                text: "Shift",
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Shift");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                text: "Alt",
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Alt");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                text: "Ctrl",
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Ctrl");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                icon: Icons.arrow_upward,
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Up");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                icon: Icons.arrow_downward,
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Down");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                icon: Icons.chevron_left,
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Left");
                }),
            (node) => SizedBox(width: 5),
            (node) => KeyboardOptionsButton(
                icon: Icons.chevron_right,
                onTap: () {
                  node.unfocus();
                  widget.onChanged?.call("Right");
                }),
            (node) => SizedBox(width: 5),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, // Set width to make it look like a keyboard button
      height: 50, // Set height to match the height of the button
      decoration: BoxDecoration(
        color: Colors.grey[300], // Light grey to mimic keyboard button
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ], // Shadow to make it look 3D like a physical button
      ),
      child: KeyboardActions(
        config: _buildConfig(context),
        child: TextField(
          focusNode: _nodeText,
          maxLength: 1, // Allow only one character input
          maxLines: 1, // Single line
          textAlign: TextAlign.center, // Center the input
          decoration: InputDecoration(
            counterText: '', // Hide the counter text
            border: InputBorder.none, // Remove the border
            hintText: '_', // Placeholder character
            hintStyle: TextStyle(
              fontSize: 24, // Increase font size for a clear placeholder
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp(r'[A-Za-z0-9]')), // Allow only alphanumeric characters
          ],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
