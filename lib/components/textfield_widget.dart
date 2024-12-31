import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.validator,
      required this.keyboardType,
      required this.controller,
      required this.hintText,
      required this.lableText});

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String hintText;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          labelText: lableText,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12))),
    );
  }
}
