import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/ScanPage.dart';
import 'package:cowshed/Page/SuhuPage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

import '../Page/HasilScanPage.dart';

class SuhuScreen extends StatefulWidget {
  SuhuScreen({Key? key}) : super(key: key);

  @override
  State<SuhuScreen> createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
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
              SuhuPage()
            ],
          ),
        ),
      ),
    );
  }
}
