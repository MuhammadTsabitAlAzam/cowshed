import 'package:cowshed/Component/StatusSapi.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class HasilScanPage extends StatefulWidget {
  @override
  _HasilScanPageState createState() => _HasilScanPageState();
}

class _HasilScanPageState extends State<HasilScanPage> {
  List<Map> _books = [
    {
      'id': 100,
      'title': 'Sehat',
    },
    {
      'id': 101,
      'title': 'Sakit',
    },
    {
      'id': 102,
      'title': 'Sehat',
    },
  ];

  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(_books.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Center(child: BoldThemedText('DATA SAPI')),
            SizedBox(height: 30,),
            _createDataTable(),
            Divider(),
          ],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Container(
            height: 55,
              child: CommonThemedText('ID Sapi')
          )
      ),
      DataColumn(
          label: Container(
            height: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonThemedText('Status'),
                  StatusDropdown()
                ],
              )
          )
      ),
      DataColumn(
          label: Container(
            height: 55,
              child: CommonThemedText('Action')
          )
      ),
    ];
  }


  List<DataRow> _createRows() {
    return _books
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final book = entry.value;
      return DataRow(
        cells: [
          DataCell(Text('#' + book['id'].toString())),
          DataCell(StatusSapi(status: book['title'],)),
          DataCell(
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  value: 'details',
                  child: Text('Details'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (String action) {
                if (action == 'details') {
                  // Lakukan sesuatu untuk aksi "Details"
                } else if (action == 'delete') {
                  // Lakukan sesuatu untuk aksi "Delete"
                }
              },
            ),
          ),
        ],
        selected: _selected[index],
        onSelectChanged: (bool? selected) {
          setState(() {
            _selected[index] = selected!;
          });
        },
      );
    })
        .toList();
  }
}

class StatusDropdown extends StatefulWidget {
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