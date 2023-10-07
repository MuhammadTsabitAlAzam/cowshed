import 'dart:io';

import 'package:cowshed/Page/DataSapiPage.dart';
import 'package:cowshed/Page/KakiPage.dart';
import 'package:flutter/material.dart';
import '../Component/UserAppbar.dart';
import '../Page/MulutPage.dart';

class DataSapiScreen extends StatefulWidget {
  final File? mulut;
  final File? kaki;
  DataSapiScreen({Key? key, this.mulut, this.kaki}) : super(key: key);

  @override
  State<DataSapiScreen> createState() => _DataSapiScreenState();
}

class _DataSapiScreenState extends State<DataSapiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataSapiPage(mulut: widget.mulut, kaki: widget.kaki,),
            ],
          ),
        ),
      ),
    );
  }
}
