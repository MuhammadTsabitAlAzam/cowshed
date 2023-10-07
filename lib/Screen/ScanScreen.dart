import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/ScanPage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

import '../Page/HasilScanPage.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
              ScanSapiPage()
            ],
          ),
        ),
      ),
    );
  }
}
