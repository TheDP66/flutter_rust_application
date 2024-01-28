import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    super.key,
    required this.title,
    this.inputFormatters,
    this.validator,
    this.onChange,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
  });

  final String title;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        TextFormField(
          autofocus: autofocus,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(hintText: hintText),
          onChanged: onChange,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
