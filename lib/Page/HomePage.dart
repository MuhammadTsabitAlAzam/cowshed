import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  final PersistentTabController? controller;
  HomePage({Key? key, this.controller}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/ScanLogo.png',
                    height: 168,
                    width: 200,
                  ),
                  SizedBox(height: 50,),
                  DefaultButton(label: 'Scan Sapi', onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BottomNavbar(index: 1,),
                      withNavBar: false,
                    );
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
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
          ],
        ),
    );
  }
}
