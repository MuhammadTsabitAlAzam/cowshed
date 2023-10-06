import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';
import '../Templates/Color/myColor.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppBarText('Selamat Datang'),
      leading: Icon(Icons.person, color: Colors.white,),
      backgroundColor: AppColors.myColor,
      actions: [
        GestureDetector(
          onTap: () {
            _showPopupMenu(context);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox bar = context.findRenderObject() as RenderBox;
    final Offset position = bar.localToGlobal(Offset.zero) + Offset(bar.size.width, kToolbarHeight);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx + 10, position.dy + 10),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 10,),
              Text('Logout'),
            ],
          ),
        ),
      ],
    ).then((String? choice) {
      if (choice == 'logout') {
        _showLogoutDialog(context);
      }
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog();
      },
    );
  }
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      content: Text('Anda yakin ingin logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ya'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Tidak'),
        ),
      ],
    );
  }
}