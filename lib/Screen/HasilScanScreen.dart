import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

import '../Page/HasilScanPage.dart';

class HasilScanScreen extends StatefulWidget {
  HasilScanScreen({Key? key}) : super(key: key);

  @override
  State<HasilScanScreen> createState() => _HasilScanScreenState();
}

class _HasilScanScreenState extends State<HasilScanScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HasilScanPage()
            ],
          ),
        ),
      ),
    );
  }
}
