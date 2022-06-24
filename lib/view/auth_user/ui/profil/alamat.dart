// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:kebapp/view/auth_user/ui/profil/alamat_baru.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Alamat extends StatefulWidget{
  Alamat({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/alamat";
  late String emailSend;

  @override
  State<Alamat> createState() => _Alamat();
}
class _Alamat extends State<Alamat>{
  final CollectionReference _alamatUser = FirebaseFirestore.instance.collection("alamat_user");
  final CollectionReference _akunUser = FirebaseFirestore.instance.collection("akun_user");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 193, 193, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text("Pilih Alamat", style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _alamatUser.where("email", isEqualTo: widget.emailSend).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AlamatBaru(
                                emailSend: widget.emailSend, 
                                indexAlamat: documentSnapshot["id"],
                                nama: documentSnapshot["nama"],
                                nomor: documentSnapshot["telp"],
                                jalan: documentSnapshot["jalan"],
                              );
                            }));
                          },
                          splashColor: Colors.grey,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            padding: const EdgeInsets.all(10),
                            color: const Color.fromRGBO(233, 206, 206, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(documentSnapshot["nama"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context, 
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Hapus Alamat Tersimpan"),
                                              content: const Text("Apakah Anda yakin ingin menghapus alamat ini?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  }, 
                                                  child: const Text("Tidak", style: TextStyle(color: Colors.red),),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    if (documentSnapshot["aktif"] == true){
                                                      await _akunUser.where("email", isEqualTo: widget.emailSend).get().then((value) {
                                                        for (DocumentSnapshot ds in value.docs) {
                                                          ds.reference.update({"create_address": false});
                                                        }
                                                      });
                                                    }
                                                    await _alamatUser.doc(documentSnapshot.id).delete();
                                                    Navigator.pop(context);
                                                  }, 
                                                  child: const Text("Ya", style: TextStyle(color: Colors.green),),
                                                )
                                              ],
                                            );
                                          }
                                        );
                                      }, 
                                      icon: const Icon(Icons.delete)
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(documentSnapshot["telp"]),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Text(documentSnapshot["jalan"]),
                                          ),
                                          Text("${documentSnapshot["kecamatan"]}, ${documentSnapshot["kabupaten_kota"]}, ${documentSnapshot["provinsi"]}, ID ${documentSnapshot["kode_pos"]}"),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            try {
                                              await _alamatUser.doc(documentSnapshot.id).update({"aktif" : true});
                                              await _alamatUser
                                              .where("id", isNotEqualTo: documentSnapshot["id"])
                                              .where("email", isEqualTo: widget.emailSend)
                                              .get()
                                              .then(
                                                (value) {
                                                  for (DocumentSnapshot ds in value.docs) {
                                                    ds.reference.update({"aktif": false});
                                                  }
                                                }
                                              );
                                              await _akunUser.where("email", isEqualTo: widget.emailSend).get().then((value) {
                                                for (DocumentSnapshot ds in value.docs) {
                                                  ds.reference.update({"create_address": true});
                                                }
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mengaktifkan Alamat")));
                                            } catch(e) {
                                              print (e.toString());
                                            }
                                          }, 
                                          icon: documentSnapshot["aktif"] != true 
                                            ? const Icon(Icons.close, color: Colors.red,) 
                                            : const Icon(Icons.done, color: Colors.green,)
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AlamatBaru(
                          emailSend: widget.emailSend, 
                          indexAlamat: 0 + snapshot.data!.docs.length,
                          nama: "",
                          nomor: "",
                          jalan: "",
                        );
                      }));
                      _alamatUser.add({
                        "id": 0 + snapshot.data!.docs.length,
                        "email": widget.emailSend,
                        "nama": "",
                        "telp": "",
                        "alamat_lengkap": "",
                        "desa_kelurahan": "",
                        "kecamatan": "",
                        "kabupaten_kota": "",
                        "provinsi": "",
                        "kode_pos": "",
                        "negara": "",
                        "jalan": "",
                        "aktif": false,
                        "latitude": 0,
                        "longitude": 0,
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: const Color.fromRGBO(233, 206, 206, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Tambah Alamat Baru"), 
                            Icon(Icons.add)
                          ],
                        ),
                      ),
                    )
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
      ),
    );
  }
}