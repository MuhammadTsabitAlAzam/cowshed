import 'package:cowshed/Screen/MulutScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/ScanTextField.dart';
import 'package:flutter/material.dart';

class SuhuPage extends StatelessWidget {
  SuhuPage({Key? key}) ;

  final TextEditingController _suhu =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        children: [
          BoldThemedText('DATA SAPI'),
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
                ScanTextField(controller: _suhu)
              ],
            ),
          ),
          SizedBox(height: 40,),
          DefaultButton(label: 'Scan Mulut Sapi', onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MulutScreen()),
              );
          })
        ],
      ),

    );
  }
}