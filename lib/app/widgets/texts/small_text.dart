import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  const SmallText(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.displayMedium);
}
