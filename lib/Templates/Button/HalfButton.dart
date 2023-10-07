import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:flutter/material.dart';

class HalfButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  HalfButton({required this.label, required this.onPressed}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2-45,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.myColor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Atur radius ke 10
          ),
        ),
      ),
    );
  }
}
