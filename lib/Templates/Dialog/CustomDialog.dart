import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;

  CustomDialog({required this.title, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text('Ya'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Menutup dialog
          },
          child: Text('Tutup'),
        ),
      ],
    );
  }
}
