import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/DaftarUserPage.dart';
import 'package:flutter/material.dart';

import '../Templates/Color/myColor.dart';
import '../Templates/Text/Text.dart';

class DaftarUserScreen extends StatefulWidget {
  DaftarUserScreen({Key? key}) : super(key: key);

  @override
  State<DaftarUserScreen> createState() => _DaftarUserScreenState();
}

class _DaftarUserScreenState extends State<DaftarUserScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myColor,
        title: AppBarText('Daftar User'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DaftarUserPage()
            ],
          ),
        ),
      ),
    );
  }
}
