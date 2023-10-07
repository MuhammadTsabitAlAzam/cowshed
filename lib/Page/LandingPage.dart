import 'package:cowshed/Screen/LoginScreen.dart';
import 'package:cowshed/Screen/RegisterScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Container(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/cowshedLogo.png',
                    width: 231,
                    height: 181,
                  ),
                  SizedBox(height: 250,),
                  DefaultButton(
                      label: 'Login',
                      onPressed: (){Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );}),
                  SizedBox(height: 20,),
                  DefaultButton(
                      label: 'Register',
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      })
                ],
              ),
            ),

        ),
      ),
    );
  }
}
