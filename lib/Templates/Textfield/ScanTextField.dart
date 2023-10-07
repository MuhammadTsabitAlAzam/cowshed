import 'package:flutter/material.dart';

class ScanTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isRequired;
  ScanTextField({
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
            )
        ),
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
