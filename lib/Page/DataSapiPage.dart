import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Api/CowApi.dart';
import '../Api/GetLocation.dart';
import '../Component/BottomNavbar.dart';
import '../Models/CowModels.dart';
import '../Templates/Dialog/CustomSnackbar.dart';
import '../Templates/Dialog/SendCowDialog.dart';
import '../Templates/Text/Text.dart';
import '../Templates/Button/DefaultButton.dart';

class DataSapiPage extends StatefulWidget {
  final File? kaki;
  final File? mulut;
  final String id;
  final double suhu;
  DataSapiPage({
    this.mulut,
    this.kaki,
    required this.id,
    required this.suhu,
  });

  @override
  _DataSapiPageState createState() => _DataSapiPageState();
}

class _DataSapiPageState extends State<DataSapiPage> {
  double lat = 0;
  double lng = 0;
  Position? _currentPosition;
  bool isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    final hasPermission = await Location().handleLocationPermission(context);
    try {
      Position position = await Geolocator.getCurrentPosition(

        desiredAccuracy: LocationAccuracy.high,
      );
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => _currentPosition = position);
      }).catchError((e) {
        debugPrint(e);
      });
      setState(() {
        _currentPosition = position;
        lat = _currentPosition?.latitude ?? 0.0;
        lng = _currentPosition?.longitude ?? 0.0;
        isLocationLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      isLocationLoading = false;
    }
  }

  bool isLoading = false;

  void _sendData() {
    if (isLocationLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final apiService = ApiServiceCow();
    final cowData = CowModel(
        idSapi: widget.id,
        suhu: widget.suhu,
        kaki: widget.kaki!,
        mulut: widget.mulut!,
        lat: lat,
        lng: lng
    );

    apiService.uploadCowData(cowData).then((response) {
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final cowApiResponse = CowApiResponse.fromJson(jsonData);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SendCowDialog(
              title: 'Berhasil Mengirim Data',
              id_sapi: cowApiResponse.idSapi,
              mulut: cowApiResponse.mulut,
              kaki: cowApiResponse.kaki,
              status: cowApiResponse.status,
              suhu: cowApiResponse.suhu,
              label: (cowApiResponse.status == 'Tidak teridentifikasi') ? 'Scan Ulang' : 'OK',
              onPressed: () {
                if (cowApiResponse.status == 'Tidak teridentifikasi') {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BottomNavbar(index: 1),
                    withNavBar: false,
                  );
                } else {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BottomNavbar(index: 2),
                    withNavBar: false,
                  );
                }
              },
            );
          },
        );
      } else {
        CustomSnackbar.instance.show(context, 'Gagal mengirim data. Kode status: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Terjadi kesalahan: $error');
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(lat);
    print(lng);
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
                      CommonThemedText(widget.id),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      UnderlineThemedText('Suhu Sapi*'),
                      SizedBox(height: 10,),
                      CommonThemedText(widget.suhu.toString()+'°C')
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
                        height: 100,
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
                        height: 100,
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
              onPressed: isLocationLoading ? (){} : _sendData,
              label: isLoading ? 'Mengirim...' : 'Kirim',
              child: isLocationLoading ? CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }
}
