import 'package:cowshed/Api/AdminApi.dart';
import 'package:cowshed/Models/AdminModels.dart';
import 'package:cowshed/Templates/Button/PaginationButton.dart';
import 'package:cowshed/Templates/Button/RoleDropDown.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import '../Templates/Color/myColor.dart';
import '../Templates/Dialog/ConfitmationMessage.dart';
import '../Templates/Dialog/NotifActionDialog.dart';
import '../Templates/Dialog/NotifDialog.dart';


class DaftarUserPage extends StatefulWidget {
  @override
  _DaftarUserPageState createState() => _DaftarUserPageState();
}

class _DaftarUserPageState extends State<DaftarUserPage> {
  List<DaftarUser> _usersDataList = [];
  int pageNumber = 1;
  int pageSize = 5;
  int totalPages = 0;
  String role = '';
  TextEditingController name = TextEditingController();

  void _handleSearch() {
    fetchData(name: name.text, role: role ,pageNumber: pageNumber, pageSize: pageSize);
  }

  void handleStatusChange(String newRole) {
    setState(() {
      role = newRole;
    });
    fetchData(name: name.text, role: newRole, pageNumber: pageNumber, pageSize: pageSize);
  }


  @override
  void initState() {
    super.initState();
    fetchData(name: name.text, pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<void> fetchData({String? name, String? role ,int? pageNumber, int? pageSize}) async {
    try {
      final usersDataResponse = await ApiServiceAdmin().getUsersData(name: name, role: role ,pageNumber: pageNumber, pageSize: pageSize);

      setState(() {
        _usersDataList = usersDataResponse.data;
        this.pageNumber = pageNumber ?? 1;
        this.totalPages = usersDataResponse.meta.totalPages;
      });
    } catch (e) {
      throw Exception("Failed to fetch cow data: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        child: Column(
          children: [
            Center(child: BoldThemedText('Daftar Users')),
            SizedBox(height: 30,),
            _createDataTable(),
            Divider(),
            SizedBox(height: 30,),
            _createPaginationButton(),
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
          child: CommonThemedText('Username')
      )),
      DataColumn(
          label: Container(
              height: 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonThemedText('Name'),
                  Container(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      style: TextStyle(fontSize: 12, color: AppColors.myColor),
                      controller: name,
                      onChanged: (value){_handleSearch();},
                    ),
                  ),
                  //IdSearch(cari: cari)
                ],
              )
          )
      ),
      DataColumn(
          label: Container(
              height: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonThemedText('Role'),
                  RoleDropdown(role: role, onStatusChanged: handleStatusChange)
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
    return _usersDataList.asMap().entries.map((entry) {
      final index = entry.key;
      final usersData = entry.value;
      return DataRow(
        cells: [
          DataCell(Text(usersData.username)),
          DataCell(Text(usersData.name)),
          DataCell(Text(usersData.role)),
          DataCell(
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: CommonThemedText('Delete'),
                    trailing: Icon(Icons.delete, color: Colors.red,),
                  ),
                ),
              ],
              onSelected: (String action) async {
                 if (action == 'delete') {
                  bool? _delete = await ConfirmationMessage.showConfirmationDialog(
                      context,
                      'Delete',
                      'Apakah Anda Yakin Ingin Menghapus Data Ini ?',
                      'Ya'
                  );
                  if (_delete == true){
                    try {
                      final response = await ApiServiceAdmin().deleteUsersData(usersData.id);
                      if (response.statusCode == 204) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NotifActionDialog(
                              title: 'Delete Berhasil',
                              content: 'Anda Berhasil Menghapus User',
                              onPressed: () {
                                _handleSearch();
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NotifDialog(
                              title: 'Delete Gagal',
                              content: 'Anda Gagal Menghapus User',
                            );
                          },
                        );
                      }
                    } catch (e) {
                      // Terjadi kesalahan dalam proses penghapusan
                    };
                  }
                }
              },
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _createPaginationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PaginationButton(
          pageNumber: pageNumber,
          totalPages: totalPages,
          pageSize: pageSize,
          onNextPage: () {
            if (totalPages>pageNumber){
              fetchData(name: name.text, role: role, pageNumber: pageNumber + 1, pageSize: pageSize);
            }
          },
          onPreviousPage: () {
            if (pageNumber > 1) {
              fetchData(name: name.text, role: role, pageNumber: pageNumber - 1, pageSize: pageSize);
            }
          },
        ),
      ],
    );
  }
}

