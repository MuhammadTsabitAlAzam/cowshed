import 'package:cowshed/Screen/EditProfileScreen.dart';
import 'package:cowshed/Templates/Button/DefaultButton.dart';
import 'package:cowshed/Templates/ListTile/SuffixListile.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/profilebackground.png',),
          fit: BoxFit.fill,
        )
      ),
      height: _height-50,
      width: _width,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
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
                  backgroundImage: AssetImage('assets/logo/WhatsApp Image 2023-10-02 at 23.14.33.jpeg'),
                  //child: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                CommonThemedText('Nama Lengkap',),
                LightThemedText('email@example.com',),
              ],
            ),
          ),
          SizedBox(height: 30,),
          SuffixListTile(
              prefixIcon: Icons.person,
              label: 'Edit Profil',
              suffixIcon: Icons.chevron_right_outlined,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          SizedBox(height: 10,),
          SuffixListTile(
            prefixIcon: Icons.info_outline,
            label: 'Tentang',
            suffixIcon: Icons.chevron_right_outlined,
            onPressed: (){

            },
          ),
          Expanded(child: Container(), flex: 1,),
          DefaultButton(
                label: 'Logout',
                onPressed: (){}
            ),
        ],
      ),
    );
  }
}
