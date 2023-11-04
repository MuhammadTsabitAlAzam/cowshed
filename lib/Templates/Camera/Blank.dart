import 'package:flutter/material.dart';

class Blank extends StatelessWidget {
  const Blank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black)
      ),
      child: Center(
        child: Text ('Tidak Ada Gambar'),
      ),
    );
  }
}
