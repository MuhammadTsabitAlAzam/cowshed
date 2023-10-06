import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Screen/RegisterScreen.dart';
import 'package:cowshed/Templates/Button/CustomTextButton.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/Common.dart';
import 'package:cowshed/Templates/Textfield/Password.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Container(
            child: Column(
                children: [
                  Image.asset(
                    'assets/logo/cowshedLogo.png',
                    width: 231,
                    height: 181,
                  ),
                  SizedBox(height: 50,),
                  TitleText('LOGIN'),
                  SizedBox(height: 50,),
                  CommonTextField(label: 'Username', controller: _username),
                  SizedBox(height: 25,),
                  PasswordField(controller: _password),
                  SizedBox(height: 25,),
                  DefaultButton(label: 'Login', onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavbar()),
                    );
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum Punya Akun?'),
                      CustomTextButton(label: 'Daftar disini', onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
