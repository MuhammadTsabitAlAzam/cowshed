import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/ScanLogo.png',
                    height: 168,
                    width: 200,
                  ),
                  SizedBox(height: 50,),
                  DefaultButton(label: 'Scan Sapi', onPressed: (){}),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  DefaultUnderlinedText(
                    'Berita Wabah PMK'
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 300,
              color: Colors.grey.shade300,
            )
          ],
        ),
    );
  }
}
