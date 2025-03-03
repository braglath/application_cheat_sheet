import 'package:application_cheatsheets/app/widgets/texts/title_text.dart';
import 'package:flutter/material.dart';

class KeyboardOptionsButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final void Function()? onTap;
  const KeyboardOptionsButton(
      {this.text, required this.onTap, this.icon, super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black
                      .withOpacity(0.5), // Semi-transparent bottom for gloss
                ],
              ),
            ),
            child: icon == null ? TitleText(text ?? '') : Icon(icon),
          ),
        ),
        // Container(
        //   color: Colors.white,
        //   padding: EdgeInsets.all(8.0),
        //   child: Text(
        //     "Shift",
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
      );
}
