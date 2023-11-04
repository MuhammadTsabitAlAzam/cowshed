import 'package:cowshed/Screen/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cowshed/Api/UserApi.dart';
import 'package:cowshed/Component/BottomNavbar.dart';
import 'package:cowshed/Screen/LoginScreen.dart';
import 'package:cowshed/Screen/RegisterScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<bool> hasTokenFuture;

  @override
  void initState() {
    super.initState();
    hasTokenFuture = checkAccessToken();
  }

  Future<bool> checkAccessToken() async {
    final accessToken = await ApiServiceUser().getAccessToken();
    return accessToken != null;
  }

  void checkAndAccessFeature() async {
    final apiService = ApiServiceUser();
    try {
      final hasPermission = await apiService.checkPermission();
      if (hasPermission) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavbar()),
        );
      }
      else {
        await ApiServiceUser().deleteAccessToken();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }

    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Center(
          child: FutureBuilder<bool>(
            future: hasTokenFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.data == true) {
                  checkAndAccessFeature();
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/logo/cowshedLogo.png',
                        width: 231,
                        height: 181,
                      ),
                      SizedBox(height: 250),
                      DefaultButton(
                        label: 'Login',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      DefaultButton(
                        label: 'Register',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
