// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:kebapp/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailKebab extends StatelessWidget{
  DetailKebab({
    Key? key, 
    required this.email,
    required this.detailToping,
    required this.detailPrice, 
    required this.detailImage,
    required this.totalPriceSize, 
    required this.typeSize
  }) : super(key: key);
  static const routeName = "/detail_kebab";
  late String email, detailToping, detailImage, typeSize;
  late int detailPrice, totalPriceSize;

  // Menghubungan ke table temp_keranjang
  final CollectionReference _tempKeranjang = FirebaseFirestore.instance.collection("temp_keranjang");

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(227, 40, 96, 0.78),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(60)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(detailImage),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        const SizedBox(height: 17,),
                        Text(
                          "Kebab Toping $detailToping",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Text("+ Rp ${detailPrice.toString()}", style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 18,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(Data().textTentangKami, style: const TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Card(
                color: const Color.fromRGBO(227, 40, 96, 0.78),
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
                  height: 45,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: (){
                      if (typeSize == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pilih Ukuran Kebab Terlebih Dahulu")));
                        Navigator.pop(context);
                      } else {
                        // Menambahkan data ke table keranjang di firestore
                        _tempKeranjang.add({
                          "email": email,
                          "item": "Kebab " + detailToping,
                          "image": detailImage,
                          "qty": 1,
                          "size": typeSize,
                          "sizePrice": totalPriceSize,
                          "toppingPrice": detailPrice,
                          "totalPrice": detailPrice + totalPriceSize,
                          "value": false
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Ditambahkan ke Keranjang")));
                        Navigator.pop(context);
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Tambahkan ke keranjang",
                        style: TextStyle(
                          fontSize: 18, 
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}