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
  bool _isCameraInitialized = false;

  void _pickImage() async {
    if (_isCameraInitialized) {
      try {
        await _cameraController.setFlashMode(FlashMode.off);
        final XFile? pickedImage = await _cameraController.takePicture();
        if (pickedImage != null) {
          if (_isPictureTaken) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialog(
                  title: 'Konfirmasi',
                  content: 'Apakah Anda ingin menghapus foto sebelumnya?',
                  onPressed: () {
                    if (picture != null) {
                      picture!.delete();
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
          } else {
            setState(() {
              picture = File(pickedImage.path);
              _isPictureTaken = true;
            });
          }
        }
      } catch (e) {
        print("Error taking picture: $e");
      }
    }
  }



  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
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
              if (_isCameraInitialized && _isPictureTaken==false)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8 / previewAspectRatio,
                      child: ClipRect(
                        child: Transform.scale(
                          scale: _cameraController.value.aspectRatio / previewAspectRatio,
                          child: Center(
                            child: CameraPreview(_cameraController),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: _width-150,
                      width: _width-110,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.red, width: 2)
                      ),
                    )
                  ],
                )
              else if (picture != null)
                Image.file(
                  picture!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
          SizedBox(height: 20),
          DefaultButton(label: 'Ambil Gambar', onPressed: _pickImage),
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
