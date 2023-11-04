import 'dart:convert';
import 'package:cowshed/Screen/ProfileScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Dialog/NotifDialog.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/Common.dart';
import 'package:cowshed/Templates/Textfield/Password.dart';
import 'package:cowshed/Templates/Textfield/PhoneNumber.dart';
import 'package:flutter/material.dart';
import '../Api/UserApi.dart';
import '../Models/UserModels.dart';
import '../Templates/Dialog/CustomSnackbar.dart';

class AddUserPage extends StatefulWidget {
  static TextEditingController _nama = TextEditingController();
  static TextEditingController _username = TextEditingController();
  static TextEditingController _nomorHp = TextEditingController();
  static TextEditingController _alamat = TextEditingController();
  static TextEditingController _password = TextEditingController();
  static TextEditingController _repassword = TextEditingController();
  static TextEditingController _lat = TextEditingController();
  static TextEditingController _lng = TextEditingController();

  @override
  State<AddUserPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<AddUserPage> {
  String _selectedRole = 'User';
  User createUserToRegister() {
    final User user = User(
      username: AddUserPage._username.text,
      password: AddUserPage._password.text,
      name: AddUserPage._nama.text,
      address: AddUserPage._alamat.text,
      no_telp: AddUserPage._nomorHp.text,
      role: _selectedRole,
    );

    if (_selectedRole == 'Puskeswan') {
      user.lat = double.parse(AddUserPage._lat.text);
      user.lng = double.parse(AddUserPage._lng.text);
    }

    return user;
  }


  Future<void> registerUser(BuildContext context) async {
    if (AddUserPage._nama.text.isEmpty ||
        AddUserPage._username.text.isEmpty ||
        AddUserPage._nomorHp.text.isEmpty ||
        AddUserPage._alamat.text.isEmpty ||
        AddUserPage._password.text.isEmpty ||
        AddUserPage._repassword.text.isEmpty ||
        (_selectedRole == 'Puskeswan' && AddUserPage._lat.text.isEmpty) ||
        (_selectedRole == 'Puskeswan' && AddUserPage._lng.text.isEmpty)
    )
    {
      CustomSnackbar.instance.show(context, "Semua field harus diisi");
    }
    else if (AddUserPage._password.text == AddUserPage._repassword.text) {
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
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NotifDialog(
              title: "Tambah User Berhasil",
              content: "Selamat Anda Berhasil Tambah User",
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
        NotifDialog(title: 'Tambah User Gagal', content: 'Tambah User Gagal',);
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
                  TitleText('Tambah User'),
                  SizedBox(height: 30,),
                  CommonTextField(label: 'Nama Lengkap*', controller: AddUserPage._nama),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Username*', controller: AddUserPage._username),
                  SizedBox(height: 15,),
                  PhoneNumberField(labelText: 'Nomor HP*', controller: AddUserPage._nomorHp),
                  SizedBox(height: 15,),
                  CommonTextField(label: 'Alamat*', controller: AddUserPage._alamat),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: _width/2-30,
                          child: PasswordField(controller: AddUserPage._password)
                      ),
                      SizedBox(width: 15,),
                      Container(
                          width: _width/2-30,
                          child: PasswordField(controller: AddUserPage._repassword, label: 'Ulangi Password*',)
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    items: ['User', 'Puskeswan']
                        .map((role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Visibility(
                    visible: _selectedRole == 'Puskeswan',
                    child: CommonTextField(label: 'Latitude*', controller: AddUserPage._lat),
                  ),
                  SizedBox(height: 15,),
                  Visibility(
                    visible: _selectedRole == 'Puskeswan',
                    child: CommonTextField(label: 'Longitude*', controller: AddUserPage._lng),
                  ),
                  SizedBox(height: 35,),
                  DefaultButton(label: 'Tambah',  onPressed: () {
                    registerUser(context);
                  }),
                  SizedBox(height: 20,),
                  
                ],
              ),
            ),
      ),
    );
  }
}
