import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:http/http.dart' as http;
import 'package:cowshed/Api/UserApi.dart';
import 'package:cowshed/Component/StatusSapi.dart';
import 'package:flutter/material.dart';
import '../Api/CowApi.dart';
import '../Models/CowModels.dart';
import '../Templates/Dialog/CustomSnackbar.dart';
import '../Templates/Text/Text.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailSapiPage extends StatefulWidget {
  final String id;
  DetailSapiPage({
    required this.id,
  });

  @override
  _DetailSapiPageState createState() => _DetailSapiPageState();
}

class _DetailSapiPageState extends State<DetailSapiPage> {
  CowDetails? cowDetails;
  String? token;
  String? role;

  @override
  void initState() {
    super.initState();
    _getCowDetails();
    _getAccessToken();
  }

  bool isLoading = false;

  Future<void> _getAccessToken() async {
    token = await ApiServiceUser().getAccessToken();
    role = await ApiServiceUser().getRole();
  }

  void _getCowDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final String cowId = widget.id;
      final apiService = ApiServiceCow();
      final details = await apiService.getCowDetails(cowId);

      setState(() {
        cowDetails = details;
        isLoading = false;
      });
    } catch (e) {
      CustomSnackbar.instance.show(context, 'Gagal mendapatkan data');
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
            else if (cowDetails != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Data Sapi"),
                  _buildTable("ID Sapi", CommonThemedText(cowDetails!.idSapi)),
                  _buildTable("Suhu", CommonThemedText("${cowDetails!.suhu}°C")),
                  _buildTable("Tanggal", CommonThemedText(_formatDate(cowDetails!.createdAt))),
                  _buildTable("Kondisi Kaki", StatusSapi(status: cowDetails!.kaki)),
                  _buildTable("Kondisi Mulut", StatusSapi(status: cowDetails!.mulut)),
                  _buildTable("Status", StatusSapi(status: cowDetails!.status)),
                  _buildTable("Foto Kaki", _buildImage(cowDetails!.kakiImg)),
                  _buildTable("Foto Mulut", _buildImage(cowDetails!.mulutImg)),
                  _buildSectionTitle("Data Owner"),
                  _buildTable("Alamat", CommonThemedText(cowDetails!.owner.address)),
                  _buildTable("No. Telp", CommonThemedText(cowDetails!.owner.noTelp)),
                  _buildSectionTitle("Data Puskeswan Terdekat"),
                  _buildTable("Nama ", CommonThemedText(cowDetails!.puskeswan.name)),
                  _buildTable("Alamat ", CommonThemedText(cowDetails!.puskeswan.address)),
                  _buildTable("No. Telp ", CommonThemedText(cowDetails!.puskeswan.noTelp)),
                  SizedBox(height: 30,),
                  Center(child: _buildContactButton())
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildContactButton() {
    return DefaultButton(
      onPressed: () {
        _launchContactOptions();
      },
      label: role == 'Puskeswan' ? 'Hubungi Pasien' : 'Hubungi Puskeswan',
    );
  }

  Widget _buildTable(String label, Widget value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: CommonThemedText(label),
          ),
          Expanded(
            flex: 1,
            child: value,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String id) {
    return FutureBuilder(
      future: _getImageUrl(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final imageUrl = snapshot.data as String;
          return Container(
            child: Image.network(
              imageUrl,
              headers: <String, String>{
                'Authorization': 'Bearer $token',
              },
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }

  Future<String> _getImageUrl(String id) async {
    final url = "http://62.72.56.98:4000/image/$id";
    final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return url;
    } else {
      throw Exception('Failed to load image');
    }
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  void _launchContactOptions() async {
    String phoneNumber = role == 'puskeswan' ? cowDetails!.owner.noTelp : cowDetails!.puskeswan.noTelp;
    final String telUrl = 'tel://$phoneNumber';
    final String whatsappUrl = 'https://wa.me/$phoneNumber';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CommonThemedText('Telepon'),
                trailing: Icon(Icons.call, color: AppColors.myColor,),
                onTap: () async {
                  if (await canLaunch(telUrl)) {
                    await launch(telUrl);
                  } else {
                    CustomSnackbar.instance.show(context, 'Gagal membuka aplikasi telepon');
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: CommonThemedText('WhatsApp'),
                trailing: Image.asset(
                    'assets/logo/whatssapp.png',
                  width: 25,
                  height: 25,
                ),
                onTap: () async {
                  if (await canLaunch(whatsappUrl)) {
                    await launch(whatsappUrl);
                  } else {
                    CustomSnackbar.instance.show(context, 'Gagal membuka aplikasi WhatsApp');
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
