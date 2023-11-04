import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  CommonTextField({
    required this.label,
    required this.controller,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor)
        )
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Harap isi $label';
        }
        return null;
      },
    );
  }
}
