import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class EdukasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: BoldBlackText("Penyakit Mulut dan Kuku (PMK)"),
          ),
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.topLeft,
            child: NormalBlackText("PMK merupakan penyakit yang disebabkan oleh virus tipe A dari keluarga Picornaviride, dan virus ini dapat menyerang berbagai spesies hewan yang berkuku genap, salah satunya sapi."),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.topLeft,
            child: NormalBlackText("PMK merupakan salah satu penyakit hewan menular yang morbiditasnya tinggi dan kerugian ekonomi yang ditimbulkan sangat besar."),
          ),
          SizedBox(height: 15,),
          Center(
            child: BoldBlackText("Gejala Klinis PMK"),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.topLeft,
            child: NormalBlackText("• Demam di atas 41 derajat celcius\n• Hipersalivasi/berliur berlebihan\n• Ada lesi/luka lepuh pada lidah\n• Papila lidah lepas\n• Kuku kaki sapi melepas dan pincang jalannya\n• Sapi tidak nafsu untuk makan\n"),
          ),
          SizedBox(height: 10,),
          Center(
            child: BoldBlackText("Apa yang harus dilakukan jika tanda-tanda tersebut muncul?"),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                NormalBlackText("• Segera pisahkan sapi yang terkena PMK, dengan cara mengeluarkan sapi yang sehat terlebih dahulu"),
                NormalBoldBlackText("• Jangan sekali-kali menyentuh sapi sehat jika sebelumnya menyentuh sapi sakit"),
                NormalBlackText("• Jangan memberi sesuatu yang tidak terbukti kebenarannya"),
                NormalBoldBlackText("• Segera hubungi PUSKESWAN atau dokter hewan terdekat"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
