import "package:flutter/material.dart";
import 'package:kebapp/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Keranjang extends StatefulWidget{
  const Keranjang({Key? key}) : super(key: key);
  static const routeName = "/keranjang";

  @override
  State<Keranjang> createState() => _Keranjang();
}

class _Keranjang extends State<Keranjang>{

  final CollectionReference _keranjang = FirebaseFirestore.instance.collection("temp_keranjang");

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: _keranjang.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    int _index = documentSnapshot["qty"];
                    int _totalPrice = documentSnapshot["totalPrice"];
                    int _toppingPrice = documentSnapshot["toppingPrice"];
                    int _sizePrice = documentSnapshot["sizePrice"];
                    bool? _value = documentSnapshot["value"];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: _value,
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                onChanged: (bool? value) async {
                                  await _keranjang.doc(documentSnapshot.id).update({
                                    "value": value
                                  });
                                },
                              ),
                              Container(
                                width: 95,
                                height: 70,
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
                                    image: NetworkImage(documentSnapshot["image"]),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(documentSnapshot["item"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),),
                                  Text("Ukuran : ${documentSnapshot["size"]}", style: const TextStyle(fontSize: 16, color: Colors.black),),
                                  Text("Rp ${documentSnapshot["totalPrice"]}", style: const TextStyle(fontSize: 16, color: Colors.red),),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 21,
                                    height: 21,
                                    color: const Color.fromRGBO(234, 185, 185, 1),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      child: const Center(
                                        child: Icon(Icons.remove, size: 15),
                                      ),
                                      onTap: () async {
                                        if (_index >= 1) {
                                          await _keranjang.doc(documentSnapshot.id).update({
                                            "qty": _index -= 1,
                                            "totalPrice": _totalPrice -= _sizePrice + _toppingPrice
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 21,
                                    height: 21,
                                    color: const Color.fromRGBO(234, 185, 185, 1),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      child: Center(
                                        child: Text(documentSnapshot["qty"].toString())
                                      ),
                                      onTap: (){},
                                    ),
                                  ),
                                  Container(
                                    width: 21,
                                    height: 21,
                                    color: const Color.fromRGBO(234, 185, 185, 1),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      child: const Center(
                                        child: Icon(Icons.add, size: 15),
                                      ),
                                      onTap: () async {
                                        await _keranjang.doc(documentSnapshot.id).update({
                                          "qty": _index += 1,
                                          "totalPrice": _totalPrice += _sizePrice + _toppingPrice
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No Data"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}