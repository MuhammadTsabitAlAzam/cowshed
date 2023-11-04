import 'package:flutter/material.dart';
import '../Component/UserAppbar.dart';
import '../Page/MulutPage.dart';

class MulutScreen extends StatefulWidget {
  final String id;
  final double suhu;

  MulutScreen({
    required this.id,
    required this.suhu
  });

  @override
  State<MulutScreen> createState() => _MulutScreenState();
}

class _MulutScreenState extends State<MulutScreen> {
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
              MulutPage(id: widget.id, suhu: widget.suhu,),
            ],
          ),
        ),
      ),
    );
  }
}
