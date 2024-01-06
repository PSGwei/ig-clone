import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.onSaved,
    required this.validator,
    this.isPassword = false,
  });

  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
