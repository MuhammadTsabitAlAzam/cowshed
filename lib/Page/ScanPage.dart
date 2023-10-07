import 'package:cowshed/Screen/SuhuScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:cowshed/Templates/Textfield/ScanTextField.dart';
import 'package:flutter/material.dart';

class ScanSapiPage extends StatelessWidget {
  ScanSapiPage({Key? key}) ;

  final TextEditingController _id =  TextEditingController();

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
                      ScanTextField(controller: _id)
                    ],
                  ),
            ),
            SizedBox(height: 40,),
            DefaultButton(label: 'Scan Sapi',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuhuScreen()),
                  );
            })
          ],
        ),

    );
  }
}
