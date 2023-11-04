import 'package:cowshed/Component/UserAppbar.dart';
import 'package:cowshed/Page/HomePage.dart';
import 'package:cowshed/Scraper/Scraper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomePage(),
              Scraper(),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
