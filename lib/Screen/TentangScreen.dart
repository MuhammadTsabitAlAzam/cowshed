import 'package:cowshed/Page/TentangPage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

import '../Page/HasilScanPage.dart';

class TentangScreen extends StatefulWidget {
  TentangScreen({Key? key}) : super(key: key);

  @override
  State<TentangScreen> createState() => _TentangScreenState();
}

class _TentangScreenState extends State<TentangScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediumThemedText('Tentang'),
            SizedBox(width: 10,),
            Icon(Icons.info_outline, color: AppColors.myColor,)
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TentangPage()
            ],
          ),
        ),
      ),
    );
  }
}
