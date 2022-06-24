// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/keranjang.dart';
import 'package:kebapp/view/auth_user/ui/menu/menu.dart';
import 'package:kebapp/view/auth_user/ui/profil/profil.dart';

class MyBottomNavigationBar extends StatefulWidget{
  MyBottomNavigationBar({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/bottom_navbar";
  late String emailSend;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBar();
}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context){
    final List<Widget> _children = [
      Menu(emailSend: widget.emailSend,),
      Keranjang(emailSend: widget.emailSend),
      MyProfile(emailSend: widget.emailSend,)
    ];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      resizeToAvoidBottomInset: false,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromRGBO(223, 80, 97, 1),
        iconSize: 40,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Shop"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
    );
  }
}