import "package:flutter/material.dart";
import 'package:kebapp/data.dart';

class UbahAkun extends StatefulWidget{
  UbahAkun({Key? key}) : super(key: key);
  static const routeName = "/ubah_akun";

  @override
  State<UbahAkun> createState() => _UbahAkun();
}

class _UbahAkun extends State<UbahAkun>{
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
        title: const Text("Ubah Akun", style: TextStyle(color: Colors.black),),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 22,),
            Container(
              width: 68,
              height: 68,
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
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 22, right: 22),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text(Data().username, style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("No. Telp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text(Data().username, style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Alamat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text(Data().username, style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text(Data().username, style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 76,),
                  Card(
                    color: const Color.fromRGBO(227, 40, 96, 0.78),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: SizedBox(
                      height: 50,
                      child: InkWell(
                        child: const Center(
                          child: Text("SIMPAN", style: TextStyle(color: Colors.white),),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}