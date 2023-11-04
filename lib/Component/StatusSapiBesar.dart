import 'package:flutter/material.dart';

class StatusSapiBesar extends StatelessWidget {
  final String status;

  StatusSapiBesar({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'sehat') {
      return Container(
        height: 25,
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1.5, color: Colors.green)),
        child: Center(
          child: Text(
            'Sehat',
            style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (status == 'sakit'){
      return Container(
        height: 25,
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.red)),
        child: Center(
          child: Text(
            'Sakit',
            style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (status == 'Tidak teridentifikasi') {
      return Container(
        height: 30,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Center(
          child: Text(
            'Tidak teridentifikasi',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Container(
      height: 30,
      width: 75,
    );

  }
}
