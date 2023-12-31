import 'package:flutter/material.dart';

class StatusSapi extends StatelessWidget {
  final String status;

  StatusSapi({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'sehat') {
      return Container(
        height: 20,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.green)),
        child: Center(
          child: Text(
            'Sehat',
            style: TextStyle(color: Colors.green, fontSize: 10),
          ),
        ),
      );
    } else {
      return Container(
        height: 20,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.red)),
        child: Center(
          child: Text(
            'Sakit',
            style: TextStyle(color: Colors.red, fontSize: 10),
          ),
        ),
      );
    }
  }
}
