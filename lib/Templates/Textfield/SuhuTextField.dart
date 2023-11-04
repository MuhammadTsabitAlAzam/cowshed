import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuhuTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isRequired;

  SuhuTextField({
    required this.controller,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'ex. 1234',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          suffixText: '°C',
          suffixStyle: TextStyle(color: AppColors.myColor),
          counterText: '',
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Harap isi data';
          }
          return null;
        },
      ),
    );
  }
}