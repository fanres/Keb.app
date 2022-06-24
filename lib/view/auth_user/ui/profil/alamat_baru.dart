// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:kebapp/view/auth_user/ui/profil/google_maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlamatBaru extends StatefulWidget{
  AlamatBaru({
    Key? key, 
    required this.emailSend, 
    required this.indexAlamat,
    required this.nama,
    required this.nomor,
    required this.jalan
  }) : super(key: key);

  static const routeName = "/alamat_baru";
  late String emailSend;
  late int indexAlamat;
  late String nama;
  late String nomor;
  late String jalan;

  @override
  State<AlamatBaru> createState() => _AlamatBaru();
}

class _AlamatBaru extends State<AlamatBaru>{
  final CollectionReference _alamatUser = FirebaseFirestore.instance.collection("alamat_user");

  @override
  Widget build(BuildContext context){
    final nameController = TextEditingController(text: widget.nama);
    final nomorController = TextEditingController(text: widget.nomor);
    final jalanController = TextEditingController(text: widget.jalan);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 193, 193, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text("Alamat Baru", style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: _alamatUser.where("email", isEqualTo: widget.emailSend).where("id", isEqualTo: widget.indexAlamat).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const Text("Kontak"),
                          TextFormField(
                            autofocus: false,
                            controller: nameController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: "Nama Lengkap",
                              hintStyle: TextStyle(color: Color.fromRGBO(161, 141, 141, 1)),
                              focusColor: Color.fromRGBO(233, 206, 206, 1),
                              fillColor: Color.fromRGBO(233, 206, 206, 1),
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                            ),
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: nomorController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: "Nomor Telepon",
                              hintStyle: TextStyle(color: Color.fromRGBO(161, 141, 141, 1)),
                              focusColor: Color.fromRGBO(233, 206, 206, 1),
                              fillColor: Color.fromRGBO(233, 206, 206, 1),
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Alamat"),
                          InkWell(
                            splashColor: Colors.grey,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return GoogleMapsScreen(emailSend: widget.emailSend, indexAlamat: widget.indexAlamat,);
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              color: const Color.fromRGBO(233, 206, 206, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 17),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Provinsi, Kota, Kecamatan, Kode Pos", style: TextStyle(fontSize: 16, color: Color.fromRGBO(161, 151, 151, 1)),),
                                    Icon(Icons.arrow_right_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: jalanController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: "Nama Jalan, Gedung, No. Rumah",
                              hintStyle: TextStyle(color: Color.fromRGBO(161, 141, 141, 1)),
                              focusColor: Color.fromRGBO(233, 206, 206, 1),
                              fillColor: Color.fromRGBO(233, 206, 206, 1),
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(233, 206, 206, 1))
                              ),
                            ),
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
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      splashColor: Colors.white,
                      child: const Center(
                        child: Text("Simpan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                      ),
                      onTap: () async {
                        await _alamatUser.doc(snapshot.data!.docs[0].id).update({
                          "nama": nameController.text,
                          "telp": nomorController.text,
                          "jalan": jalanController.text,
                        });
                        nameController.text = "";
                        nomorController.text = "";
                        jalanController.text = "";
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Semua Alamat Berhasil Tersimpan")));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}