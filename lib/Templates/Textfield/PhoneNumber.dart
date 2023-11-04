import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool isRequired;
  final bool isPhoneNumberValid;

  PhoneNumberField({
    required this.controller,
    required this.labelText,
    this.hintText = 'Masukkan nomor telepon',
    this.errorText = 'Nomor telepon tidak valid',
    this.isRequired = true,
    this.isPhoneNumberValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: isPhoneNumberValid ? null : errorText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor),
        ),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Harap isi nomor telepon';
        }
        if (!isPhoneNumberValid) {
          return errorText;
        }
        return null;
      },
    );
  }
}
