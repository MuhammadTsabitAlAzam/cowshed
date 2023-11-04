import 'dart:convert';

import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Screen/RegisterScreen.dart';
import 'package:cowshed/Templates/Button/CustomTextButton.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/Common.dart';
import 'package:cowshed/Templates/Textfield/Password.dart';
import 'package:flutter/material.dart';
import '../Api/UserApi.dart';
import '../Models/UserModels.dart';
import '../Templates/Dialog/CustomSnackbar.dart';
import '../Templates/Dialog/NotifDialog.dart';

class LoginPage extends StatefulWidget {
  static TextEditingController _username = TextEditingController();
  static TextEditingController _password = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginRequest createLoginData() {
    return LoginRequest(
      username: LoginPage._username.text,
      password: LoginPage._password.text,
    );
  }

  Future<void> loginUser(BuildContext context) async {
    if (LoginPage._username.text.isEmpty) {
      CustomSnackbar.instance.show(context, "Username harus diisi.");
    } else if (LoginPage._password.text.isEmpty) {
      CustomSnackbar.instance.show(context, "Password harus diisi.");
    } else {
      LoginRequest loginData = createLoginData();

      try {
        final response = await ApiServiceUser().loginUser(loginData);

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final accessToken = responseData['access']['token'] as String;
          final name = responseData['user']['name'] as String;
          final role = responseData['user']['role'] as String;
          await ApiServiceUser().saveUserData(name, accessToken, role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavbar()),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NotifDialog(
                title: "Login Berhasil",
                content: "Selamat Anda Berhasil Login",
              );
            },
          );
        } else {
          CustomSnackbar.instance.show(context, 'Email atau Password Tidak Sesuai');
        }
      } catch (e) {
        CustomSnackbar.instance.show(context, 'Terjadi Kesalahan pada Server : $e');
      }
    }
  }

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
              SizedBox(
                height: 50,
              ),
              TitleText('LOGIN'),
              SizedBox(
                height: 50,
              ),
              CommonTextField(label: 'Username*', controller: LoginPage._username),
              SizedBox(
                height: 25,
              ),
              PasswordField(controller: LoginPage._password),
              SizedBox(
                height: 25,
              ),
              DefaultButton(
                  label: 'Login',
                  onPressed: () {
                    loginUser(context);
                  },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum Punya Akun?'),
                  CustomTextButton(
                      label: 'Daftar disini',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
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
