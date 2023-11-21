import 'package:cowshed/Screen/MulutScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/ScanTextField.dart';
import 'package:cowshed/Templates/Textfield/SuhuTextField.dart';
import 'package:flutter/material.dart';

import '../Templates/Dialog/CustomSnackbar.dart';

class SuhuPage extends StatelessWidget {
  final String id;
  SuhuPage({Key? key, required this.id}) ;

  static TextEditingController _suhu =  TextEditingController();

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
                CommonThemedText(id),
                SizedBox(height: 25,),
                UnderlineThemedText('Suhu Sapi*'),
                SizedBox(height: 10,),
                SuhuTextField(controller: _suhu)
              ],
            ),
          ),
          SizedBox(height: 40,),
          DefaultButton(label: 'Scan Mulut Sapi', onPressed: () {
            final suhuText = _suhu.text;

            if (suhuText.isNotEmpty) {
              try {
                double suhu = double.parse(suhuText);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MulutScreen(id: id, suhu: suhu)),
                );
              } catch (e) {
                CustomSnackbar.instance.show(context, 'Suhu yang dimasukkan tidak valid');
              }
            } else {
              CustomSnackbar.instance.show(context, 'Harap isi Suhu');
            }
          })
        ],
      ),
    );
  }
}
