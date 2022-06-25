// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/order_on_progress.dart';
import 'package:kebapp/view/auth_user/ui/profil/alamat.dart';

class Order extends StatefulWidget {
  Order({Key? key, required this.emailSend, required this.countItem}) : super(key: key);
  static const routeName = "/order";
  late String emailSend;
  late int countItem;

  @override
  State<Order> createState() => _Order();
}

class _Order extends State<Order> {
  double lat = 1;
  double lon = 1;

  // Menghubungkan ke tabel temp_order

  final CollectionReference _alamatUser = FirebaseFirestore.instance.collection("alamat_user");

  final CollectionReference _transaksiCOD = FirebaseFirestore.instance.collection("transaksi_cod");

  final CollectionReference _transaksiOVO = FirebaseFirestore.instance.collection("transaksi_ovo");

  final CollectionReference _transaksiGopay = FirebaseFirestore.instance.collection("transaksi_gopay");

  final CollectionReference _keranjang = FirebaseFirestore.instance.collection("temp_keranjang");

  int _radioValue = 0;
  int _opsiValue = 1;
  String metodePembayaran = "";
  String opsiPengiriman = "Reguler";
  int hargaPengiriman = 3000;
  bool? alamatControl;
  int totalPrice = 0;

  late TextEditingController? pesanController = TextEditingController();

  Future getAlamatValue() async => FirebaseFirestore.instance.collection("akun_user")
    .where("email", isEqualTo: widget.emailSend)
    .get().then((value) {
      
      setState(() {
        alamatControl = value.docs[0]["create_address"];
      });

      return alamatControl;
  });

  Future getTotalPrice() async => FirebaseFirestore.instance.collection("temp_keranjang")
    .where("email", isEqualTo: widget.emailSend)
    .where("value", isEqualTo: true)
    .get().then((value) {
      
      for (var doc in value.docs) { 
        totalPrice = totalPrice + doc["totalPrice"] as int;
       }

      return totalPrice;
  });

  @override
  void initState() {
    getTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAlamatValue();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        title: const Text(
          "Order",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                alamatControl != false 
                ? StreamBuilder(
                  stream: _alamatUser.where("email", isEqualTo: widget.emailSend).where("aktif", isEqualTo: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Alamat(emailSend: widget.emailSend);
                          }));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            padding: const EdgeInsets.all(20),
                            color: const Color.fromRGBO(216, 193, 193, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 10,),
                                    Text("Alamat Pengiriman")
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text(snapshot.data!.docs[0]["nama"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[0]["telp"]),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Text(snapshot.data!.docs[0]["jalan"]),
                                          ),
                                          Text("${snapshot.data!.docs[0]["kecamatan"]}, ${snapshot.data!.docs[0]["kabupaten_kota"]}, ${snapshot.data!.docs[0]["provinsi"]}, ID ${snapshot.data!.docs[0]["kode_pos"]}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ) 
                // Jika nilai create_address di tabel akun_user false
                : InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Alamat(emailSend: widget.emailSend);
                    }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    color: const Color.fromRGBO(216, 193, 193, 1),
                    child: const Center(
                      child: Text("No Data"),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: _keranjang.where("email", isEqualTo: widget.emailSend).where("value", isEqualTo: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 95,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(60)),
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
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              fontSize: 16,
                                              color: Colors.black),
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
                                Text("X${documentSnapshot["qty"]}"),
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
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, bottom: 15, right: 5),
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
                              const Text(
                                "Opsi Pengiriman",
                                style: TextStyle(
                                    color: Color.fromRGBO(111, 72, 72, 1)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(opsiPengiriman)
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Scaffold(
                                      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
                                      appBar: AppBar(
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                            "Pilih Opsi Pengiriman",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        iconTheme: const IconThemeData(
                                            color: Colors.black),
                                      ),
                                      body: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 13,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: const [
                                                            Text("Reguler"),
                                                            Text("Rp 3000")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Radio(
                                                      value: 1,
                                                      groupValue: _opsiValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _opsiValue = value as int;
                                                          opsiPengiriman = "Reguler";
                                                          hargaPengiriman = 3000;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 13,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: const [
                                                            Text("Cepat"),
                                                            Text("Rp 5000")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Radio(
                                                      value: 2,
                                                      groupValue: _opsiValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _opsiValue = value as int;
                                                          opsiPengiriman = "Cepat";
                                                          hargaPengiriman = 5000;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 13,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: const [
                                                            Text("Kilat"),
                                                            Text("Rp 7000")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Radio(
                                                      value: 3,
                                                      groupValue: _opsiValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _opsiValue = value as int;
                                                          opsiPengiriman = "Kilat";
                                                          hargaPengiriman = 7000;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Card(
                                            color: const Color.fromRGBO(227, 40, 96, 0.78),
                                            elevation: 5,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 40,
                                              child: InkWell(
                                                splashColor: Colors.white,
                                                child: const Center(
                                                  child: Text(
                                                    "Konfirmasi",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                onTap: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Anda Memilih Pengiriman $opsiPengiriman")));
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Rp $hargaPengiriman",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Icon(Icons.arrow_right_sharp)
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Pesan: "),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              autofocus: false,
                              controller: pesanController,
                              decoration: const InputDecoration(
                                hintText: "Silakan tinggalkan pesan",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 181, 165, 165),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pesanan (${widget.countItem}) Produk: "),
                          Text(
                            "Rp $totalPrice",
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(216, 193, 193, 1),
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(65, 54, 54, 1)),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Scaffold(
                                          backgroundColor: const Color.fromRGBO(
                                              233, 206, 206, 1),
                                          appBar: AppBar(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                                "Pilih Metode pembayaran",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            iconTheme: const IconThemeData(
                                                color: Colors.black),
                                          ),
                                          body: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset(
                                                                "assets/images/cod.png"),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text(
                                                                    "COD (Bayar di Tempat)"),
                                                                Text(
                                                                    "Cash On Delivery")
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Radio(
                                                          value: 1,
                                                          groupValue:
                                                              _radioValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _radioValue =
                                                                  value as int;
                                                              metodePembayaran =
                                                                  "COD";
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 13,
                                                            ),
                                                            Image.asset(
                                                                "assets/images/ovo.png"),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text("OVO"),
                                                                Text(
                                                                    "0838 xxxx xxxx")
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Radio(
                                                          value: 2,
                                                          groupValue:
                                                              _radioValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _radioValue =
                                                                  value as int;
                                                              metodePembayaran =
                                                                  "OVO";
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Image.asset(
                                                                "assets/images/gopay.png"),
                                                            const SizedBox(
                                                              width: 13,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text("Gopay"),
                                                                Text(
                                                                    "0838 xxxx xxxx")
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Radio(
                                                          value: 3,
                                                          groupValue:
                                                              _radioValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _radioValue =
                                                                  value as int;
                                                              metodePembayaran =
                                                                  "Gopay";
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Card(
                                                color: const Color.fromRGBO(227, 40, 96, 0.78),
                                                elevation: 5,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 40,
                                                  child: InkWell(
                                                    splashColor: Colors.white,
                                                    child: const Center(
                                                      child: Text(
                                                        "Konfirmasi",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Anda memilih $metodePembayaran")));
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    _radioValue == 0 
                                    ? const Text("Silahkan Pilih") 
                                    : Text(metodePembayaran),
                                    const Icon(Icons.arrow_right_sharp)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal Produk"),
                          Text("Rp $totalPrice"),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal Pengiriman"),
                          Text("Rp $hargaPengiriman"),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Pembayaran",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Rp ${totalPrice + hargaPengiriman}",
                            style: const TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total Pembayaran",
                            style: TextStyle(color: Color.fromRGBO(65, 54, 54, 1)),
                          ),
                          Text(
                            "Rp ${totalPrice + hargaPengiriman}",
                            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    color: const Color.fromRGBO(227, 40, 96, 0.78),
                    child: InkWell(
                      splashColor: Colors.white,
                      child: const Center(
                        child: Text(
                          "Buat Pesanan",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        if (_radioValue != 0 && alamatControl != false) {
                          // Menghapus semua data di tabel temp_keranjang
                          _keranjang.where("email", isEqualTo: widget.emailSend).where("value", isEqualTo: true).get().then((value) {
                            for (DocumentSnapshot ds in value.docs) {
                              ds.reference.delete();
                            }
                          });

                          if (_radioValue == 1) {
                            _transaksiCOD.add({
                              "email": widget.emailSend,
                              "metode_pembayaran": metodePembayaran,
                              "total_harga": totalPrice + hargaPengiriman
                            });
                          } else if (_radioValue == 2) {
                            _transaksiOVO.add({
                              "email": widget.emailSend,
                              "metode_pembayaran": metodePembayaran,
                              "total_harga": totalPrice + hargaPengiriman
                            });
                          } else if (_radioValue == 3) {
                            _transaksiGopay.add({
                              "email": widget.emailSend,
                              "metode_pembayaran": metodePembayaran,
                              "total_harga": totalPrice + hargaPengiriman
                            });
                          }
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                            return OrderOnProgress(
                              emailSend: widget.emailSend,
                              latitude: lat,
                              longitude: lon,
                            );
                          }), (route) => false);
                        } else if (_radioValue == 0 && alamatControl != false) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pilih Metode Pembayaran Dahulu")));
                        } else if (_radioValue != 0 && alamatControl == false) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pilih Alamat Aktif Dahulu")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Anda Belum Mengaktifkan Alamat dan Memilih Metode Pembayaran")));
                        }
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
