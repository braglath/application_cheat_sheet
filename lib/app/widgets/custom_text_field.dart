import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool? isEnabled;
  final String? hint;
  final String? errorText;
  final TextCapitalization? textCapitalization;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  final void Function(String)? onChanged;

  final int? maxlines;
  const CustomTextField(
      {required this.label,
      required this.onChanged,
      this.isEnabled,
      this.hint,
      this.errorText,
      this.textCapitalization,
      this.keyboardType,
      this.inputFormatter,
      this.maxlines,
      super.key});

  @override
  Widget build(BuildContext context) => TextField(
      enabled: isEnabled ?? true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        hintText: hint,
        errorText: errorText,
        filled: true,
        fillColor: Theme.of(context).cardColor,
      ),
      maxLines: maxlines,
      minLines: 1,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: inputFormatter,
      onChanged: onChanged);
}
