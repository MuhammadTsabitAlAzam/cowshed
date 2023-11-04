import 'package:flutter/material.dart';

class ConfirmationMessage {
  static Future<bool?> showConfirmationDialog(
      BuildContext context, String title, String content, String text) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Menghapus
              },
              child: Text(text),
            ),
          ],
        );
      },
    );
  }
}

class SuccessMessage {
  static Future<bool?> showSuccessMessage(
      BuildContext context, String title, String content) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Tidak menghapus
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
