// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Riwayat extends StatelessWidget{
  Riwayat({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/riwayat";
  late String emailSend;

  final CollectionReference _riwayat = FirebaseFirestore.instance.collection("riwayat");

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
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _riwayat.where("email",isEqualTo: emailSend).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(documentSnapshot["status"], style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 95,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                    image: DecorationImage(
                                      image: NetworkImage(documentSnapshot["image"]),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(documentSnapshot["item"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    Text("Ukuran: ${documentSnapshot["ukuran"]}"),
                                    Text("Total Pesanan: Rp ${documentSnapshot["total_biaya"]}"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}