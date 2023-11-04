import 'package:flutter/material.dart';
import '../Text/Text.dart';

class RoleDropdown extends StatefulWidget {
  late final String? role;
  final Function(String) onStatusChanged;
  RoleDropdown({required this.role, required this.onStatusChanged});
  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String selectedStatus = 'Semua';
  List<String> statusOptions = ['Semua', 'user', 'puskeswan'];

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