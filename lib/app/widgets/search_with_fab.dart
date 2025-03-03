import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:application_cheatsheets/app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SearchWithFab extends StatelessWidget {
  final void Function()? onFabPressed;
  final void Function(String)? onTextFieldChanged;
  final String? textLabel;

  final IconData? icon;
  final String? fabLabel;

  const SearchWithFab(
      {required this.onFabPressed,
      required this.onTextFieldChanged,
      this.textLabel,
      this.icon,
      this.fabLabel,
      super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "FAB",
            onPressed: onFabPressed,
            icon: Icon(icon ?? Icons.add),
            label: Text(fabLabel ?? AppString.addApp),
          ),
          CustomTextField(
              label: textLabel ?? 'Search', onChanged: onTextFieldChanged),
        ],
      );
}
