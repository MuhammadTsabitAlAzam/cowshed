import 'dart:io';

import 'package:cowshed/Page/KakiPage.dart';
import 'package:flutter/material.dart';
import '../Component/UserAppbar.dart';
import '../Page/MulutPage.dart';

class KakiScreen extends StatefulWidget {
  final File? mulut;
  KakiScreen({Key? key, this.mulut}) : super(key: key);

  @override
  State<KakiScreen> createState() => _KakiScreenState();
}

class _KakiScreenState extends State<KakiScreen> {
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
              KakiPage(mulut: widget.mulut,),
            ],
          ),
        ),
      ),
    );
  }
}
