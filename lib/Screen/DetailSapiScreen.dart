import 'package:cowshed/Page/DetailSapiPage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';
import '../Component/UserAppbar.dart';

class DetailSapiScreen extends StatefulWidget {
  final String id;
  DetailSapiScreen({
    required this.id,
  });

  @override
  State<DetailSapiScreen> createState() => _DetailSapiScreenState();
}

class _DetailSapiScreenState extends State<DetailSapiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sapi', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: AppColors.myColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DetailSapiPage(id: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}
