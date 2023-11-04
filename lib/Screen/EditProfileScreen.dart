import 'package:cowshed/Page/EditProfilePage.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import '../Models/UserModels.dart';

class EditProfileScreen extends StatefulWidget {
  final User? user;
  final String? token;
  final String? img;
  EditProfileScreen({
    this.user,
    this.token,
    this.img
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myColor,
        title: AppBarText('Edit Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EditProfilePage(user: widget.user, token: widget.token, img: widget.img,)
            ],
          ),
        ),
      ),
    );
  }
}
