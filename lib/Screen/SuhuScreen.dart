import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/SuhuPage.dart';
import 'package:flutter/material.dart';

class SuhuScreen extends StatefulWidget {
  final String id;
  SuhuScreen({Key? key, required this.id}) : super(key: key);

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
              SuhuPage(id: widget.id,)
            ],
          ),
        ),
      ),
    );
  }
}
