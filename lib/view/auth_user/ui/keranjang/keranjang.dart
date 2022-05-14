import "package:flutter/material.dart";
import 'package:kebapp/data.dart';

class Keranjang extends StatefulWidget{
  const Keranjang({Key? key}) : super(key: key);
  static const routeName = "/keranjang";

  @override
  State<Keranjang> createState() => _Keranjang();
}

class _Keranjang extends State<Keranjang>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Keranjang Saya", style: TextStyle(color: Colors.black),),
            Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(120)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.54),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(Data().imageProfile),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(child: Text("Keranjang"),),
    );
  }
}