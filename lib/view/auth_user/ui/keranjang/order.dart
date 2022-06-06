import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);
  static const routeName = "/order";

  @override
  State<Order> createState() => _Order();
}

class _Order extends State<Order> {
  // Menghubungkan ke tabel temp_order
  final CollectionReference _order = FirebaseFirestore.instance.collection("temp_order");

  int count = 0;
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        title: const Text("Order", style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              height: 100,
              color: const Color.fromRGBO(216, 193, 193, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on),
                      Text("Tidak ada alamat yang tersimpan"),
                      IconButton(
                        icon: Icon(Icons.arrow_right_sharp),
                        onPressed: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _order.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  count = streamSnapshot.data!.docs.length;
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      totalPrice = documentSnapshot["price_order"];
                      return Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 95,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(60)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(documentSnapshot["image_order"]),
                                      fit: BoxFit.cover)),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  documentSnapshot["item_order"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                Text(
                                  "Ukuran : ${documentSnapshot["size_order"]}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  "Rp ${documentSnapshot["price_order"]}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              ],
                            ),
                            Text("X${documentSnapshot["qty_order"]}"),
                          ],
                        ),
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
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              color: const Color.fromRGBO(219, 205, 205, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Opsi Pengiriman", style: TextStyle(color: Color.fromRGBO(111, 72, 72, 1)),),
                          Text("Reguler")
                        ],
                      ),
                      Text("Rp 3000", style: TextStyle(color: Colors.black),)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pesan: "),
                      Text("Silahkan tinggalkan pesan", style: TextStyle(color: Color.fromRGBO(161, 151, 151, 1)),)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pesanan ($count) Produk: "),
                      Text("Rp $totalPrice", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Metode Pembayaran"),
                      Text("Silahkan Pilih"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal Produk"),
                      Text("Rp $totalPrice"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal Pengiriman"),
                      Text("Rp 3000"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pembayaran", style: TextStyle(fontSize: 18),),
                      Text("Rp ${totalPrice + 3000}", style: TextStyle(color: Colors.red, fontSize: 18),),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Pembayaran", style: TextStyle(color: Color.fromRGBO(65, 54, 54, 1)),),
                          Text("Rp $totalPrice", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    color: const Color.fromRGBO(227, 40, 96, 0.78),
                    child: InkWell(
                      splashColor: Colors.white,
                      child: const Center(
                        child: Text("Buat Pesanan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      onTap: (){
                        // Menghapus semua data di tabel temp_order
                        _order.get().then((value) {
                          for (DocumentSnapshot ds in value.docs) {
                            ds.reference.delete();
                          }
                        });
                        Navigator.pushNamed(context, "/google_maps");
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}