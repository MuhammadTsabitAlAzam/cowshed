import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cowshed/Screen/KakiScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Templates/Dialog/CustomDialog.dart';
import '../Templates/Text/Text.dart';
import '../Templates/Button/DefaultButton.dart';

class MulutPage extends StatefulWidget {
  final String id;
  final double suhu;
  MulutPage({
    required this.id,
    required this.suhu,
  });

  @override
  _MulutPageState createState() => _MulutPageState();
}

class _MulutPageState extends State<MulutPage> {
  File? picture;
  bool _isPictureTaken = false;
  final double previewAspectRatio = 0.7;
  late CameraController _cameraController;

  Future<void> _showConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Konfirmasi',
          content: 'Apakah Anda ingin mengganti foto?',
          onPressed: () async {
            if (picture != null) {
              picture!.delete();
              _showImagePickerOptions();
            }
            setState(() {
              picture = null;
              _isPictureTaken = false;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _captureImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          picture = File(pickedImage.path);
          _isPictureTaken = true;
        });
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _captureImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _captureImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          BoldThemedText('DATA SAPI'),
          SizedBox(height: 30),
          if (picture == null)
            Container(
              height: _width - 150,
              width: _width - 110,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Colors.black
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Text("Tidak Ada gambar"),
              ),
            )
          else
            Image.file(
              picture!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 20),
          DefaultButton(label: 'Ambil Gambar', onPressed: _isPictureTaken? _showConfirmationDialog :_showImagePickerOptions,),
          SizedBox(height: 20),
          DefaultButton(
            label: 'Scan Kaki Sapi',
            onPressed: () {
              if (picture != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KakiScreen(
                      mulut: picture,
                      id: widget.id,
                      suhu: widget.suhu,
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlineThemedText('ID Sapi*'),
                SizedBox(height: 10),
                CommonThemedText(widget.id),
                SizedBox(height: 25),
                UnderlineThemedText('Suhu Sapi*'),
                SizedBox(height: 10),
                CommonThemedText(widget.suhu.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
