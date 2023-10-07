import 'dart:io';
import 'package:cowshed/Templates/Button/HalfButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Templates/Color/myColor.dart';
import '../Templates/Text/Text.dart';
import '../Templates/Button/DefaultButton.dart';

class DataSapiPage extends StatefulWidget {
  final File? kaki;
  final File? mulut;
  DataSapiPage({Key? key, this.mulut, this.kaki}) : super(key: key);

  @override
  _DataSapiPageState createState() => _DataSapiPageState();
}

class _DataSapiPageState extends State<DataSapiPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoldThemedText('DATA SAPI'),
            SizedBox(height: 30,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UnderlineThemedText('ID Sapi*'),
                      CommonThemedText('XXXX'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      UnderlineThemedText('Suhu Sapi*'),
                      SizedBox(height: 10,),
                      CommonThemedText('XXXX')
                    ],
                  ),
                ],
              ),
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20,),
                        UnderlineThemedText('Gambar Kaki*'),
                        SizedBox(height: 10,),
                        Container(
                          child: widget.kaki != null
                              ? Image.file(
                            widget.kaki!,
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                              : Text('Tidak ada gambar kaki'),
                        )
                      ],
                    ),
                ],
              ),
            SizedBox(height: 40,),
            DefaultButton(
              onPressed: (){},
              label: 'Kirim',
            ),
          ],
        ),
      ),
    );
  }
}
