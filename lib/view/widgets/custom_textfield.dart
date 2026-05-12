import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;


  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hintText,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

  }
}
