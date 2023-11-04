import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final bool isRequired;

  PasswordField({
    required this.controller,
    this.label,
    this.isRequired = true,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.myColor),
        ),
        labelText: widget.label ?? 'Password*',
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {setState(() {_obscurePassword = !_obscurePassword;});},
        ),
      ),
      obscureText: _obscurePassword,
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Harap isi ${widget.label}';
        }
        return null;
      },
    );
  }
}
