import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/EditProfilePage.dart';
import 'package:cowshed/Page/HomePage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EditProfilePage()
            ],
          ),
        ),
      ),
    );
  }
}
