import 'package:cowshed/Component/StatusSapi.dart';
import 'package:cowshed/Component/StatusSapiBesar.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class SendCowDialog extends StatelessWidget {
  final String title;
  final String id_sapi;
  final String mulut;
  final String kaki;
  final String status;
  final String label;
  final double suhu;
  final Function() onPressed;

  SendCowDialog({
    required this.title,
    required this.id_sapi,
    required this.status,
    required this.suhu,
    required this.onPressed,
    required this.mulut,
    required this.kaki,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonThemedText('ID Sapi: $id_sapi'),
            SizedBox(height: 10,),
            CommonThemedText('Suhu: $suhu °C'),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonThemedText('Mulut'),
                Spacer(),
                CommonThemedText(': '),
                Spacer(),
                StatusSapiBesar(status: mulut)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonThemedText('Kaki  '),
                Spacer(),
                CommonThemedText(': '),
                Spacer(),
                StatusSapiBesar(status: kaki)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonThemedText('Status'),
                Spacer(),
                CommonThemedText(': '),
                Spacer(),
                StatusSapiBesar(status: status)
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
              onPressed();
            },
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
