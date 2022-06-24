// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:kebapp/view/widget/bottom_navbar.dart';

class OrderComplete extends StatelessWidget {
  OrderComplete({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/order_complete";
  late String emailSend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 193, 193, 1),
      appBar: AppBar(
        title: const Text("Pesanan Berhasil", style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: const [
                SizedBox(height: 60,),
                Text("SELAMAT!!!", style: TextStyle(fontSize: 30),),
                SizedBox(height: 60,),
                Icon(Icons.check_box, color: Colors.green, size: 100,),
                SizedBox(height: 40,),
                Text("Pesanan Berhasil Dibuat", style: TextStyle(fontSize: 20),),
              ],
            ),
            Column(
              children: [
                Card(
                  color: const Color.fromRGBO(229, 76, 120, 1),
                  elevation: 5,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                        return MyBottomNavigationBar(emailSend: emailSend,);
                      }), (route) => false);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      height: 40,
                      child: const Center(
                        child: Text("Home", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
              ],
            )
          ],
        ),
      ),
    );
  }
}