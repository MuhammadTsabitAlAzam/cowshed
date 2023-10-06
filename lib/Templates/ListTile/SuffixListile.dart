import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class SuffixListTile extends StatelessWidget {
  final IconData prefixIcon;
  final String label;
  final IconData suffixIcon;
  final Function() onPressed;

  SuffixListTile({
    required this.prefixIcon,
    required this.label,
    required this.suffixIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(prefixIcon),
      title: CommonThemedText(label),
      trailing: IconButton(
        icon: Icon(suffixIcon),
        onPressed: onPressed,
      ),
    );
  }
}
