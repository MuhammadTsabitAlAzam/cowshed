import 'package:flutter/material.dart';

class NotifActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;

  NotifActionDialog({required this.title, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: onPressed,
            child: Text('Ya'),
          ),
        ),
      ],
    );
  }
}
