import 'package:flutter/material.dart';

class NotifDialog extends StatelessWidget {
  final String title;
  final String content;

  NotifDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Menutup dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
