import "package:flutter/material.dart";

class TentangKami extends StatelessWidget{
  const TentangKami({Key? key}) : super(key: key);
  static const routeName = "/tentang_kami";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Tentang Kami", style: TextStyle(color: Colors.black),),
      ),
      body: Center(),
    );
  }
}