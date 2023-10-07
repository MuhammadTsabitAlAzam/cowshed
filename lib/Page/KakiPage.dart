import 'dart:io';

import 'package:cowshed/Page/DataSapiPage.dart';
import 'package:cowshed/Screen/DataSapiScreen.dart';
import 'package:cowshed/Templates/Button/HalfButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Templates/Color/myColor.dart';
import '../Templates/Text/Text.dart';
import '../Templates/Button/DefaultButton.dart';

class KakiPage extends StatefulWidget {
  final File? mulut;
  KakiPage({Key? key, this.mulut}) : super(key: key);

  @override
  _KakiPageState createState() => _KakiPageState();
}

class _KakiPageState extends State<KakiPage> {
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
    return SingleChildScrollView(
      child: Container(
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
                    height: 300,
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
            Container(
              width: MediaQuery.of(context).size.width-70,
              child: Row(
                children: [
                  HalfButton(
                    label: 'Kembali',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 20,),
                  HalfButton(
                    label: 'Kirim',
                    onPressed: () {
                      if (picture != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DataSapiScreen(mulut: widget.mulut, kaki: picture,),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UnderlineThemedText('ID Sapi*'),
                            CommonThemedText('XXXX'),
                            SizedBox(height: 25,),
                            UnderlineThemedText('Suhu Sapi*'),
                            SizedBox(height: 10,),
                            CommonThemedText('XXXX')
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 20,),
                            UnderlineThemedText('Gambar Mulut*'),
                            SizedBox(height: 10,),
                            Container(
                              child: widget.mulut != null
                                  ? Image.file(
                                widget.mulut!,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                                  : Text('Tidak ada gambar mulut'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
