import 'dart:io';

import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Screen/ProfileScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Api/UserApi.dart';
import '../Models/UserModels.dart';
import '../Templates/Dialog/CustomDialog.dart';
import '../Templates/Dialog/NotifDialog.dart';
import '../Templates/Textfield/Common.dart';
import '../Templates/Textfield/Password.dart';
import '../Templates/Textfield/PhoneNumber.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  final String? token;
  final String? img;
  EditProfilePage({
    this.user,
    this.token,
    this.img,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _nomorHp = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _lng = TextEditingController();
  late String _role;
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File selectedImage = File(pickedImage.path);
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nama.text = widget.user?.name ?? '';
    _username.text = widget.user?.username ?? '';
    _nomorHp.text = widget.user?.no_telp ?? '';
    _alamat.text = widget.user?.address ?? '';
    _role = widget.user?.role ?? '';
    if (_role == 'puskeswan'){
      _lat.text = widget.user?.lat.toString() ?? '';
      _lng.text = widget.user?.lng.toString() ?? '';
    }
  }

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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : NetworkImage(
                          "http://62.72.56.98:4000/image/" + widget.img.toString(),
                          headers: <String, String>{
                            'Authorization': 'Bearer ' + widget.token.toString(),
                          },
                        ) as ImageProvider<Object>
                      )

                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10,
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CommonThemedText(widget.user?.name ?? ''),
                LightThemedText(_role ?? ''),
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
          Visibility(
            visible: _role == 'puskeswan',
            child: CommonTextField(label: 'Latitude*', controller: _lat),
          ),
          SizedBox(height: 15,),
          Visibility(
            visible: _role == 'puskeswan',
            child: CommonTextField(label: 'Longitude*', controller: _lng),
          ),
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
            onPressed: () async {
              UserUpdate updatedUser = UserUpdate(
                id: widget.user?.id,
                username: _username.text,
                name: _nama.text,
                address: _alamat.text,
                no_telp: _nomorHp.text,
                password: _password.text,
                profile: _selectedImage,
                lat: _lat.text,
                lng: _lng.text
              );
              print(_selectedImage);
              try {
                final response = await ApiServiceUser().updateUserProfile(updatedUser, widget.token.toString());
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Update Berhasil',
                        content: 'Selamat, Data Anda Berhasil Diupdate',
                        onPressed: () {
                          Navigator.pop(context);
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: BottomNavbar(index: 3,),
                            withNavBar: false,
                          );
                        },
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NotifDialog(
                        title: "Gagal Update",
                        content: "Sayang Sekali, Data Gagal Diupdate(${response.statusCode})",
                      );
                    },
                  );
                }
              } catch (e) {
                 print('Terjadi kesalahan: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
