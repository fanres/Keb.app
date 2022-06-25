// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/order.dart';

class Keranjang extends StatefulWidget {
  Keranjang({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/keranjang";
  late String emailSend;

  @override
  State<Keranjang> createState() => _Keranjang();
}

class _Keranjang extends State<Keranjang> {
  int _countItem = 0; // Sebagai penghitung total item
  int totalPrice = 0; // Sebagai penghitung total harga
  bool createAddress = false;

  // Menghubungkan ke tabel temp_keranjang
  final CollectionReference _keranjang = FirebaseFirestore.instance.collection("temp_keranjang");

  // Menghubungkan ke tabel akun_user
  final CollectionReference _userAkun = FirebaseFirestore.instance.collection("akun_user");

  // Menghubungkan ke tabel riwayat
  final CollectionReference _riwayat = FirebaseFirestore.instance.collection("riwayat");

  Future getCount() async => FirebaseFirestore.instance.collection("temp_keranjang")
    .where("email", isEqualTo: widget.emailSend)
    .where("value", isEqualTo: true)
    .get().then((value) {
      
      setState(() {
        _countItem = value.docs.length;
      });

      return _countItem;
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: StreamBuilder(
          stream: _userAkun.where("email", isEqualTo: widget.emailSend).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasData) {
              createAddress = snapshot.data!.docs[0]["create_address"];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Keranjang Saya",
                    style: TextStyle(color: Colors.black),
                  ),
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
                          image: snapshot.data!.docs[0]["uploadImage"] != true 
                            ? AssetImage(snapshot.data!.docs[0]["image"]) as ImageProvider 
                            : NetworkImage(snapshot.data!.docs[0]["image"]), 
                          fit: BoxFit.cover
                        ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text("No Data");
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _keranjang.where("email", isEqualTo: widget.emailSend).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // Untuk menghitung jumlah data
                    itemCount: streamSnapshot.data!.docs.length, 
                    // Sebagai builder
                    itemBuilder: (context, index) {
                      // Untuk mengambil data di index
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      int _index = documentSnapshot["qty"];
                      int _totalPrice = documentSnapshot["totalPrice"];
                      int _toppingPrice = documentSnapshot["toppingPrice"];
                      int _sizePrice = documentSnapshot["sizePrice"];
                      bool? _value = documentSnapshot["value"];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _value,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) async {
                                    // Menambah jumlah item yang tercentang
                                    setState(() {
                                      _value = value;
                                    });
                                    // Melakukan update data pada tabel temp_keranjang
                                    await _keranjang.doc(documentSnapshot.id).update({"value": value});
                                    if (value == true) {
                                      // Memasukkan data ke tabel rowayat
                                      _riwayat.add({
                                        "email": widget.emailSend,
                                        "id_item": "${widget.emailSend}/$index",
                                        "image": documentSnapshot["image"],
                                        "item": documentSnapshot["item"],
                                        "total_biaya": documentSnapshot["totalPrice"],
                                        "ukuran": documentSnapshot["size"],
                                        "status": "Selesai"
                                      });
                                    } else if (value == false) {
                                      // menghapus data di tabel riwayat
                                      await _riwayat.where("id_item", isEqualTo: "${widget.emailSend}/$index").get().then((value) {
                                        for (DocumentSnapshot ds in value.docs) {
                                          ds.reference.delete();
                                        }
                                      });
                                    }
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
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documentSnapshot["item"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "Ukuran : ${documentSnapshot["size"]}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      "Rp ${documentSnapshot["totalPrice"]}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (_value != true) {
                                      await _keranjang.doc(documentSnapshot.id).delete();
                                    }
                                  }, 
                                  icon: const Icon(Icons.delete),
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
                                          if (_value != true) {
                                            if (_index >= 1) {
                                              // Melakukan update data di firebase
                                              await _keranjang.doc(documentSnapshot.id).update({
                                                "qty": _index -= 1,
                                                "totalPrice": _totalPrice -= _sizePrice + _toppingPrice
                                              });
                                            }
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
                                            child: Text(
                                                documentSnapshot["qty"].toString())),
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
                                          if (_value != true) {
                                            // Melakukan update data di firebase
                                            await _keranjang
                                                .doc(documentSnapshot.id)
                                                .update({
                                              "qty": _index += 1,
                                              "totalPrice": _totalPrice +=
                                                  _sizePrice + _toppingPrice
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            color: const Color.fromRGBO(227, 40, 96, 0.78),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 5,
                            child: SizedBox(
                              width: 100,
                              height: 34,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: (){
                                  // Menghapus semua data di tabel temp_keranjang
                                  if (_countItem != 0) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return Order(
                                        emailSend: widget.emailSend,
                                        countItem: _countItem,
                                      );
                                    }));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Anda belum menambahkan pesanan")));
                                  }
                                },
                                child: Center(
                                  child: Text("Order ($_countItem)", style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("No Data"),
              );
            }
          },
        ),
      ),
    );
  }
}
