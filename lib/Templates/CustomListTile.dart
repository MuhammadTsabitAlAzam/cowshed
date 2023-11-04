import 'package:flutter/material.dart';

ListTile buildCustomListTile(String title, Widget rightWidget) {
  return ListTile(
    title: Text(title),
    trailing: rightWidget,
  );
}
