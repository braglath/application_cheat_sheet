import 'package:application_cheatsheets/app/constants/app_strings.dart';
import 'package:flutter/material.dart';

class CancelAddButtons extends StatelessWidget {
  final void Function()? onCancel;
  final void Function()? onAdd;
  const CancelAddButtons(
      {required this.onCancel, required this.onAdd, super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cancel Button
          TextButton(
            onPressed: onCancel,
            child: const Text(AppString.cancel),
          ),
          // Add Button
          ElevatedButton(
            onPressed: onAdd,
            child: const Text(AppString.add),
          ),
        ],
      );
}
