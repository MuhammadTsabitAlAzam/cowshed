import 'dart:io';

import 'package:cowshed/Screen/KakiScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Templates/Color/myColor.dart';
import '../Templates/Text/Text.dart';
import '../Templates/Button/DefaultButton.dart';
import 'KakiPage.dart';

class MulutPage extends StatefulWidget {
  const MulutPage({Key? key}) : super(key: key);

  @override
  _MulutPageState createState() => _MulutPageState();
}

class _MulutPageState extends State<MulutPage> {
  File? picture;
  bool _isPictureTaken = false;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        picture = File(pickedImage.path);
        _isPictureTaken = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          BoldThemedText('DATA SAPI'),
          SizedBox(height: 30,),
          Stack(
            alignment: Alignment.center,
            children: [
              if (!_isPictureTaken)
                Container(
                  width: double.infinity,
                  height: 300, // Atur sesuai dengan kebutuhan Anda
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text('Tidak ada gambar'),
                  ),
                ),
              if (_isPictureTaken)
                Image.file(
                  picture!,
                  width: MediaQuery.of(context).size.width - 70,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          SizedBox(height: 25,),
          DefaultButton(
            onPressed: _pickImage,
            label: 'Ambil Gambar',
          ),
          SizedBox(height: 20,),
          DefaultButton(
            label: 'Scan Kaki Sapi',
            onPressed: () {
              if (picture != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KakiScreen(mulut: picture),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlineThemedText('ID Sapi*'),
                SizedBox(height: 10,),
                CommonThemedText('XXXX'),
                SizedBox(height: 25,),
                UnderlineThemedText('Suhu Sapi*'),
                SizedBox(height: 10,),
                CommonThemedText('XXXX')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
