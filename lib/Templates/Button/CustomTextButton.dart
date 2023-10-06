import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  CustomTextButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
        color: AppColors.myColor,
      ),
      ),
    );
  }
}
