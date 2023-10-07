import 'package:flutter/material.dart';
import '../Component/UserAppbar.dart';
import '../Page/MulutPage.dart';

class MulutScreen extends StatefulWidget {
  MulutScreen({Key? key}) : super(key: key);

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
              MulutPage(),
            ],
          ),
        ),
      ),
    );
  }
}
