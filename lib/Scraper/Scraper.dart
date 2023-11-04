import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';

class DataInfo {
  final String value;

  DataInfo(this.value);
}

class ZeroReport {
  final String? value;

  ZeroReport(this.value);
}

class Scraper extends StatefulWidget {
  @override
  _ScraperState createState() => _ScraperState();
}

class _ScraperState extends State<Scraper> {
  List<DataInfo> dataInfoList = [];
  List<ZeroReport> zeroReportList = [];
  List<String> titleList = ['Provinsi', 'Kab/Kota', 'Kecamatan', 'Desa', 'Vaksinasi', 'Sakit', 'Sembuh', 'Potong Bersyarat', 'Mati'];
  final List<Color> colorList = [
    Colors.blue.shade900,
    Colors.blueAccent.shade700,
    Colors.cyan,
    Colors.cyanAccent.shade400,
    Colors.orange,
    Colors.pinkAccent,
    Colors.lightGreenAccent.shade700,
    Colors.purple.shade800,
    Colors.grey.shade900
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://siagapmk.crisis-center.id/index.php'));
    if (response.statusCode == 200) {
      final document = parse(response.body);
      final elements = document.querySelectorAll(
          "#info_province, "
              "#info_city, "
              "#info_district, "
              "#info_subdistrict, "
              "#info_vaksin, "
              "#info_suspect, "
              "#info_healed, "
              "#info_prevention, "
              "#info_death,"
      );

      final zero = document.querySelectorAll(
              "#total_prov_zerro, "
              "#total_city_zerro, "
              "#total_dist_zerro, "
              "#total_subdist_zerro, "
      );

      List<DataInfo> tempDataInfoList = [];
      List<ZeroReport> tempZeroReportList = [];

      for (var element in elements) {
        final value = element.text;
        tempDataInfoList.add(DataInfo(value));
      }

      for (var i = 0; i < 9; i++) {
        if (i < zero.length) {
          final value = zero[i].text;
          tempZeroReportList.add(ZeroReport(value));
        } else {
          tempZeroReportList.add(ZeroReport(null));
        }
      }


      setState(() {
        dataInfoList = tempDataInfoList;
        zeroReportList = tempZeroReportList;
        isLoading = false;
      });
    } else {
      print('Gagal mengunduh halaman web.');
      isLoading = false;
    }
  }

  Widget buildDataInfoContainer(String title, String value, Color colors, int index, ZeroReport zero) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              color: colors,
              padding: EdgeInsets.all(10),
              child: TitleContainerText(title),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      ContentContainerText(value, colors),
                      Spacer(),
                      if (zero.value != null && zero.value!.isNotEmpty)
                        Expanded(
                          child: Container(
                            //width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  //width: 100,
                                  color: Colors.greenAccent.shade700,
                                  child: Align(
                                    alignment: Alignment.center,
                                      child: TitleContainerText(zero.value.toString())
                                  ),
                                ),
                                Container(
                                  child: Content2ContainerText('Zero Reported Case'),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  if (zero.value != null && zero.value!.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                        child: SubTitleRedText('Kasus Aktif')
                    ),

                  if (index == 4)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SubTitleText('(dosis)')
                    ),
                  if (index >=5)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SubTitleText('(ekor)')
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columnCount = (screenWidth / 150).floor();

    return SizedBox(
      height: MediaQuery.of(context).size.height/2-100,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
          childAspectRatio: 1.3,
        ),
        itemCount: dataInfoList.length,
        itemBuilder: (context, index) {
          final dataInfo = dataInfoList[index];
          final title = titleList[index];
          final colors = colorList[index];
          final zero = zeroReportList[index];
          return buildDataInfoContainer(title, dataInfo.value, colors, index, zero);
        },
      ),
    );
  }
}
