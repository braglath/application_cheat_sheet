import 'package:flutter/services.dart';

class NoConsecutiveSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value contains consecutive spaces, replace them with a single space.
    String newText = newValue.text.replaceAll(RegExp(r' {2,}'), ' ');

    // Check if the text has been modified
    if (newText != newValue.text) {
      // Ensure the cursor is placed within the bounds of the new text length
      int newCursorPosition = newValue.selection.baseOffset;

      // Prevent the cursor position from being out of bounds
      if (newCursorPosition < 0) {
        newCursorPosition = 0;
      } else if (newCursorPosition > newText.length) {
        newCursorPosition = newText.length;
      }

      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newCursorPosition),
      );
    }

    // If no change was made, return the new value as is
    return newValue;
  }
}
