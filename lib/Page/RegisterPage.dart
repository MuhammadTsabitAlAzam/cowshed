import 'package:cowshed/Screen/LoginScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/Common.dart';
import 'package:cowshed/Templates/Textfield/Password.dart';
import 'package:cowshed/Templates/Textfield/PhoneNumber.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Container(
            child: Column(
                children: [
                  Image.asset(
                    'assets/logo/cowshedLogo.png',
                    width: 231,
                    height: 181,
                  ),
                  SizedBox(height: 40,),
                  TitleText('Register'),
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
                        width: _width/2-30,
                          child: PasswordField(controller: _password)
                      ),
                      SizedBox(width: 15,),
                      Container(
                          width: _width/2-30,
                          child: PasswordField(controller: _repassword, label: 'Ulangi Password*',)
                      ),
                    ],
                  ),
                  SizedBox(height: 35,),
                  DefaultButton(label: 'Register', onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
                  SizedBox(height: 20,),
                ],
              ),
            ),
      ),
    );
  }
}
