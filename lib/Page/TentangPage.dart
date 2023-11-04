import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TentangPage extends StatefulWidget {
  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-90,
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo/cowshedLogo.png'),
                SizedBox(height: 20,),
                CommonThemedText('Version $version'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
