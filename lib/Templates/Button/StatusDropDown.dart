import 'package:flutter/material.dart';

import '../Text/Text.dart';

class StatusDropdown extends StatefulWidget {
  late final String? status;
  final Function(String) onStatusChanged;
  StatusDropdown({required this.status, required this.onStatusChanged});
  @override
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  String selectedStatus = 'Semua';
  List<String> statusOptions = ['Semua', 'Sakit', 'Sehat'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          child: DropdownButton(
            value: selectedStatus,
            onChanged: (newValue) {
              setState(() {
                selectedStatus = newValue.toString();
                if (newValue.toString() == 'Semua') {
                  widget.onStatusChanged('');
                } else {
                  widget.onStatusChanged(newValue.toString());
                }
              });
            },
            items: statusOptions.map((status) {
              return DropdownMenuItem(
                value: status,
                child: MiniBlackText(status),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}