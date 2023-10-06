import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

import '../Templates/Textfield/Common.dart';
import '../Templates/Textfield/Password.dart';
import '../Templates/Textfield/PhoneNumber.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _nomorHp = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/profilebackground.png',),
            fit: BoxFit.fill,
          )
      ),
      width: _width,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _width-70,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/logo/WhatsApp Image 2023-10-02 at 23.14.33.jpeg'),
                  //child: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                CommonThemedText('Nama Lengkap',),
                LightThemedText('email@example.com',),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.centerLeft,
              child: DefaultUnderlinedText('Data Diri')
          ),
          SizedBox(height: 30,),
          CommonTextField(label: 'Nama Lengkap*', controller: _nama),
          SizedBox(height: 15,),
          CommonTextField(label: 'Username*', controller: _username),
          SizedBox(height: 15,),
          PhoneNumberField(labelText: 'Nomor HP*', controller: _nomorHp),
          SizedBox(height: 15,),
          CommonTextField(label: 'Alamat*', controller: _alamat),
          SizedBox(height: 15,),
          Row(
            children: [
              Container(
                  width: _width/2-50,
                  child: PasswordField(controller: _password)
              ),
              SizedBox(width: 15,),
              Container(
                  width: _width/2-50,
                  child: PasswordField(controller: _repassword, label: 'Ulangi Password*',)
              ),
            ],
          ),
          SizedBox(height: 50,),
          DefaultButton(
              label: 'Simpan Perubahan',
              onPressed: (){}
          ),
        ],
      ),
    );
  }
}
