import 'package:flutter/material.dart';
import '../Color/myColor.dart';

Widget TitleText(String title) => Text(
      title,
      style: TextStyle(
          // fontFamily: '',
          fontSize: 30,
          color: Colors.cyan[800],
          fontWeight: FontWeight.bold),
    );

Widget CommonText(String title) => Text(
      title,
      style: TextStyle(
          // fontFamily: '',
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500),
    );

Widget DefaultUnderlinedText(String title) => Column(
      children: [
        Text(
          title,
          style: TextStyle(
              // fontFamily: '',
              fontSize: 15,
              color: AppColors.myColor,
              fontWeight: FontWeight.w900,),
        ),
        SizedBox(height: 5,),
        Container(
          height: 1,
          width: 150,
          color: Colors.grey,
        ),
      ],
    );

Widget BoldThemedText(String title) => Text(
  title,
  style: TextStyle(
    // fontFamily: '',
      fontSize: 35,
      color: AppColors.myColor,
      fontWeight: FontWeight.w900),
);

Widget CommonThemedText(String title) => Text(
      title,
      style: TextStyle(
          // fontFamily: '',
          fontSize: 15,
          color: AppColors.myColor,
          fontWeight: FontWeight.w700),
    );

Widget LightThemedText(String title) => Text(
      title,
      style: TextStyle(
          // fontFamily: '',
          fontSize: 12,
          color: AppColors.myColor),
    );

Widget NavbarItemText(String title) => Text(
      title,
      style: TextStyle(
          // fontFamily: '',
          fontSize: 12,
          color: Colors.white),
    );

Widget MiniBlackText(String title) => Text(
  title,
  style: TextStyle(
    // fontFamily: '',
      fontSize: 10,
      color: Colors.black),
);

Widget AppBarText(String title) => Text(
  title,
  style: TextStyle(
    // fontFamily: '',
      fontSize: 20,
      color: Colors.white, fontWeight: FontWeight.w400),
);

Widget UnderlineThemedText(String title) => Container(
  decoration:  BoxDecoration(
      border: Border(
          bottom: BorderSide(color: AppColors.myColor))
  ),
  child:   Text(
    title,
    style: TextStyle(
      // fontFamily: '',
        fontSize: 15,
        color: AppColors.myColor,
        fontWeight: FontWeight.w500,
    ),
  ),
);