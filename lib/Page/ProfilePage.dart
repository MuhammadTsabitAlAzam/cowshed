import 'package:cowshed/Screen/AddUserScreen.dart';
import 'package:cowshed/Screen/EditProfileScreen.dart';
import 'package:cowshed/Screen/TentangScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/Dialog/ConfitmationMessage.dart';
import 'package:cowshed/Templates/ListTile/SuffixListile.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Api/UserApi.dart';
import '../Models/UserModels.dart';
import '../Screen/LandingScreen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String? role;
  String? token;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      final accessToken = await ApiServiceUser().getAccessToken();
      final user = await ApiServiceUser().getUserDetailsWithAccessToken();
      final role = await ApiServiceUser().getRole();
      setState(() {
        this.user = user;
        this.role = role!;
        this.token = accessToken!;
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () => getUserDetails(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/profilebackground.png',),
            fit: BoxFit.fill,
          ),
        ),
        height: _height-50,
        width: _width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _width-70,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage("http://62.72.56.98:4000/image/${user?.profileImg}",
                        headers: <String, String>{
                        'Authorization': 'Bearer $token',
                        }
                    )
                  ),
                  const SizedBox(height: 20),
                  CommonThemedText(user?.name ?? ''),
                  LightThemedText(role ?? ''),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            SuffixListTile(
                prefixIcon: Icons.person,
                label: 'Edit Profil',
                suffixIcon: Icons.chevron_right_outlined,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen(user: user, token: token, img: user?.profileImg,),),
                );
              },
            ),
            const SizedBox(height: 10,),
            Visibility(
              visible : role == "admin" ? true : false,
              child: SuffixListTile(
                prefixIcon: Icons.person_add,
                label: 'Tambah User',
                suffixIcon: Icons.chevron_right_outlined,
                onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: AddUserScreen(),
                    withNavBar: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            SuffixListTile(
              prefixIcon: Icons.info_outline,
              label: 'Tentang',
              suffixIcon: Icons.chevron_right_outlined,
              onPressed: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: TentangScreen(),
                  withNavBar: false,
                );
              },
            ),
            Expanded(flex: 1, child: Container(),),
            DefaultButton(
                  label: 'Logout',
                  onPressed: () async {
                    bool? _logout = await ConfirmationMessage.showConfirmationDialog(
                        context,
                        'Logout',
                        'Apakah Anda Yakin Ingin Logout ?',
                        'Ya'
                    );
                    if (_logout == true){
                      logout();
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: LandingScreen(),
                        withNavBar: false,
                      );
                    }
                  }
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> logout() async {
  await ApiServiceUser().deleteAccessToken();
  await ApiServiceUser().deleteUserName();
  await ApiServiceUser().deleteRole();
}