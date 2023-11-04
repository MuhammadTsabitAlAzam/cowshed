import 'package:flutter/material.dart';

class CustomSnackbar {
  static final CustomSnackbar _instance = CustomSnackbar._internal();
  factory CustomSnackbar() => _instance;

  CustomSnackbar._internal();

  static CustomSnackbar get instance => _instance;

  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
