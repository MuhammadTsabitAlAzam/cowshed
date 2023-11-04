import 'dart:convert';
import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Screen/LoginScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Dialog/NotifDialog.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/Common.dart';
import 'package:cowshed/Templates/Textfield/Password.dart';
import 'package:cowshed/Templates/Textfield/PhoneNumber.dart';
import 'package:flutter/material.dart';
import '../Api/UserApi.dart';
import '../Models/UserModels.dart';
import '../Templates/Button/CustomTextButton.dart';
import '../Templates/Dialog/CustomSnackbar.dart';

class RegisterPage extends StatefulWidget {
  static TextEditingController _nama = TextEditingController();
  static TextEditingController _username = TextEditingController();
  static TextEditingController _nomorHp = TextEditingController();
  static TextEditingController _alamat = TextEditingController();
  static TextEditingController _password = TextEditingController();
  static TextEditingController _repassword = TextEditingController();
  static TextEditingController _lat = TextEditingController();
  static TextEditingController _lng = TextEditingController();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User createUserToRegister() {
    final User user = User(
      username: RegisterPage._username.text,
      password: RegisterPage._password.text,
      name: RegisterPage._nama.text,
      address: RegisterPage._alamat.text,
      no_telp: RegisterPage._nomorHp.text,
      role: 'user'
    );

    return user;
  }


  Future<void> registerUser(BuildContext context) async {
    if (RegisterPage._nama.text.isEmpty ||
        RegisterPage._username.text.isEmpty ||
        RegisterPage._nomorHp.text.isEmpty ||
        RegisterPage._alamat.text.isEmpty ||
        RegisterPage._password.text.isEmpty ||
        RegisterPage._repassword.text.isEmpty 
    )
    {
      CustomSnackbar.instance.show(context, "Semua field harus diisi");
    }
    else if (RegisterPage._password.text == RegisterPage._repassword.text) {
      final apiService = ApiServiceUser();

      final userToRegister = createUserToRegister();

      final response = await apiService.registerUser(userToRegister);
      if (response.statusCode == 201) {
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
              title: "Register Berhasil",
              content: "Selamat Anda Berhasil Register",
            );
          },
        );
      } else if (response.statusCode == 400) {
        try {
          final responseData = json.decode(response.body);
          final errorMessage = responseData["message"] as String;
          CustomSnackbar.instance.show(context, errorMessage);
        } catch (e) {
          CustomSnackbar.instance.show(context, "Terjadi kesalahan server (HTTP 500)");
        }
      } else {
        NotifDialog(title: 'Register Gagal', content: 'Register Gagal',);
      }
    } else {
      CustomSnackbar.instance.show(context, "Password Anda Tidak Sama");
    }
  }

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
                  CommonTextField(label: 'Nama Lengkap*', controller: RegisterPage._nama),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Username*', controller: RegisterPage._username),
                  SizedBox(height: 15,),
                  PhoneNumberField(labelText: 'Nomor HP*', controller: RegisterPage._nomorHp),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Alamat*', controller: RegisterPage._alamat),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: _width/2-30,
                          child: PasswordField(controller: RegisterPage._password)
                      ),
                      SizedBox(width: 15,),
                      Container(
                          width: _width/2-30,
                          child: PasswordField(controller: RegisterPage._repassword, label: 'Ulangi Password*',)
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Latitude', controller: RegisterPage._lat),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Longitude', controller: RegisterPage._lng),
                  SizedBox(height: 35,),
                  DefaultButton(label: 'Register',  onPressed: () {
                    registerUser(context);
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah Punya Akun?'),
                      CustomTextButton(label: 'Login disini', onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
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
