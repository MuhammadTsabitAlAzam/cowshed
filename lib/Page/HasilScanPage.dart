import 'package:cowshed/Api/CowApi.dart';
import 'package:cowshed/Component/StatusSapi.dart';
import 'package:cowshed/Screen/DetailSapiScreen.dart';
import 'package:cowshed/Templates/Button/PaginationButton.dart';
import 'package:cowshed/Templates/Dialog/CustomDialog.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Models/CowModels.dart';
import '../Templates/Button/StatusDropDown.dart';
import '../Templates/Color/myColor.dart';
import '../Templates/Dialog/ConfitmationMessage.dart';
import '../Templates/Dialog/NotifActionDialog.dart';
import '../Templates/Dialog/NotifDialog.dart';


class HasilScanPage extends StatefulWidget {
  @override
  _HasilScanPageState createState() => _HasilScanPageState();
}

class _HasilScanPageState extends State<HasilScanPage> {
  List<CowData> _cowDataList = [];
  int pageNumber = 1;
  int pageSize = 5;
  int totalPages = 0;
  String status = '';
  TextEditingController cari = TextEditingController();

  void _handleSearch() {
    fetchData(idSapi: cari.text, status: status ,pageNumber: pageNumber, pageSize: pageSize);
  }

  void handleStatusChange(String newStatus) {
    setState(() {
      status = newStatus;
    });
    fetchData(idSapi: cari.text, status: newStatus, pageNumber: pageNumber, pageSize: pageSize);
  }


  @override
  void initState() {
    super.initState();
    fetchData(idSapi: cari.text, pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<void> fetchData({String? idSapi, String? status ,int? pageNumber, int? pageSize}) async {
    try {
      final cowDataResponse = await ApiServiceCow().getCowData(idSapi: idSapi, status: status ,pageNumber: pageNumber, pageSize: pageSize);

      setState(() {
        _cowDataList = cowDataResponse.data;
        this.pageNumber = pageNumber ?? 1;
        this.totalPages = cowDataResponse.meta.totalPages;
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
              Center(child: BoldThemedText('DATA SAPI')),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonThemedText('ID Sapi'),
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
                controller: cari,
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
                  CommonThemedText('Status'),
                  StatusDropdown(status: status, onStatusChanged: handleStatusChange)
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
    return _cowDataList.asMap().entries.map((entry) {
      final index = entry.key;
      final cowData = entry.value;
      return DataRow(
        cells: [
          DataCell(Text(cowData.idSapi)),
          DataCell(StatusSapi(status: cowData.status)),
          DataCell(
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  value: 'details',
                  child: ListTile(
                      leading: CommonThemedText('Details'),
                    trailing: Icon(Icons.read_more_outlined, color: Colors.greenAccent,),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                      leading: CommonThemedText('Delete'),
                    trailing: Icon(Icons.delete, color: Colors.red,),
                  ),
                ),
              ],
              onSelected: (String action) async {
                if (action == 'details') {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: DetailSapiScreen(id: cowData.id,),
                    withNavBar: true,
                  );
                } else if (action == 'delete') {
                  bool? _delete = await ConfirmationMessage.showConfirmationDialog(
                      context,
                      'Delete',
                      'Apakah Anda Yakin Ingin Menghapus Data Ini ?',
                      'Ya'
                  );
                  if (_delete == true){
                    try {
                      final response = await ApiServiceCow().deleteCowData(cowData.id);
                      if (response.statusCode == 204) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NotifActionDialog(
                              title: 'Delete Berhasil',
                              content: 'Anda Berhasil Menghapus Data Sapi',
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
                              content: 'Anda Gagal Menghapus Data Sapi',
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
              fetchData(idSapi: cari.text, status: status, pageNumber: pageNumber + 1, pageSize: pageSize);
            }
          },
          onPreviousPage: () {
            if (pageNumber > 1) {
              fetchData(idSapi: cari.text, status: status, pageNumber: pageNumber - 1, pageSize: pageSize);
            }
          },
        ),
      ],
    );
  }
}

