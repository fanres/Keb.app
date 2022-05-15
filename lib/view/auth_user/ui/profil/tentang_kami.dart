import "package:flutter/material.dart";
import 'package:kebapp/data.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 450,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50),),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Keb.app", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),),
            const SizedBox(height: 38,),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.2,
              child: Text(
                Data().textTentangKami,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}