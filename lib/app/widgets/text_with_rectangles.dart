import 'package:flutter/material.dart';

class TextWithRectangles extends StatelessWidget {
  final String text;

  const TextWithRectangles({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Split the string by '+', trim the values and add a rectangle around each part
    List<String> parts = text.split('+').map((e) => e.trim()).toList();

    print("parts: $parts");

    // Create a list of widgets with rectangles and '+' in between
    List<Widget> widgets = [];
    for (int i = 0; i < parts.length; i++) {
      // Check if the current part is one of the predefined keywords
      String keyValue = parts[i];
      Widget currentWidget;

      if (['Up', 'Down', 'Left', 'Right'].contains(keyValue)) {
        // Show icon for predefined values
        currentWidget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Icon(
              _getIconForKey(keyValue),
              size: 24,
              color: Colors.black,
            ),
          ),
        );
      } else {
        // Otherwise, show text
        currentWidget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              keyValue,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      }

      widgets.add(currentWidget);

      // Add '+' widget if it's not the last part
      if (i < parts.length - 1) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent, // No background color for '+'
              ),
              child: Text(
                '+', // The "+" symbol
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }

  // Method to return the appropriate icon based on the key value
  IconData _getIconForKey(String keyValue) {
    switch (keyValue) {
      case 'Up':
        return Icons.arrow_upward;
      case 'Down':
        return Icons.arrow_downward;
      case 'Left':
        return Icons.arrow_left;
      case 'Right':
        return Icons.arrow_right;
      default:
        return Icons.help; // Fallback icon if something is wrong
    }
  }
}
