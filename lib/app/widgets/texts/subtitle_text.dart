import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const SubtitleText(this.text, {this.style, super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: style ?? Theme.of(context).textTheme.bodyMedium);
}
