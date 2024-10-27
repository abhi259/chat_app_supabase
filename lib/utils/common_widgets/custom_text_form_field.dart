import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Padding customTextFormField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required String? Function(String?) validator,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  void Function(String)? onFieldSubmitted,
  List<TextInputFormatter>? inputFormatters,
  int? maxLength,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(fontSize: 16),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );
}
