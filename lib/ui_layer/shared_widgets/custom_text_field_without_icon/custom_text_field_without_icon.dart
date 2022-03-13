import 'package:flutter/material.dart';


///
class CustomTextFieldWithoutIcon extends StatelessWidget {
  /// Custom text form field with out icon
   CustomTextFieldWithoutIcon({
    Key? key,
    required this.hintLabel,
    required this.controller,
    required this.textInputType,
    required this.validator,
    required this.isPassword,
  }) : super(key: key);
  /// hint text
  final String hintLabel;
  /// Text Editing Controller
  final TextEditingController controller;
  /// keyboard input type
  final TextInputType textInputType;
  bool isPassword = false;
  /// validator
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintLabel,
        filled: true,
        hintStyle:const TextStyle(
          color: Colors.grey
        ),
        fillColor: Colors.white,
        border:const OutlineInputBorder(),
          ),
        );
  }
}
