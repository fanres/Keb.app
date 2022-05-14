import "package:flutter/material.dart";

class Riwayat extends StatelessWidget{
  const Riwayat({Key? key}) : super(key: key);
  static const routeName = "/riwayat";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: const Text("Riwayat", style: TextStyle(color: Colors.black),),
      ),
      body: Center(),
    );
  }
}