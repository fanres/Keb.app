import 'package:flutter/material.dart';

import 'profile_epic.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Riwayat",
            press: () => {},
            icon: '',
          ),
          ProfileMenu(
            text: "Tentang Kami",
            press: () {},
            icon: '',
          ),
          ProfileMenu(
            text: "Logout",
            press: () {},
            icon: '',
          ),
        ],
      ),
    );
  }
}
