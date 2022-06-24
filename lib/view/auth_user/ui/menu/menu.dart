// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kebapp/view/auth_user/ui/menu/detail_kebab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget{
  Menu({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/menu";
  late String emailSend;

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu>{
  late TextEditingController? searchController = TextEditingController();
  late String searchString = "";
  bool isSearching = false;
  int _value = 0;

  final CollectionReference _menu = FirebaseFirestore.instance.collection("menu");

  final CollectionReference _userAkun = FirebaseFirestore.instance.collection("akun_user");

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: StreamBuilder(
          stream: _userAkun.where("email", isEqualTo: widget.emailSend).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasData) {
              return Row(
                children: [
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
                  const SizedBox(width: 10,),
                  Text.rich(
                    TextSpan(
                      text: "Hai, ",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                          text: snapshot.data!.docs[0]["username"],
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          )
                        ),
                      ]
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Temukan Kebab Kesukaanmu",
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold, height: 1.5,),
                ),
              ),
              const SizedBox(height: 10,),
              // Form Search Menu
              TextField(
                autofocus: false,
                controller: searchController,
                onChanged: (value){
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black,),
                  hintText: "Search For A Food Item",
                  contentPadding: EdgeInsets.only(top: 5,),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Ukuran",
                style: TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _value = 1;
                      });
                    },
                    child: Container(
                      width: 84,
                      height: 69,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 206, 206, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(161, 141, 141, 1),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: _value == 1 ? Colors.blue : const Color.fromRGBO(196, 196, 196, 1),
                          width: 2,
                        )
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Text("S", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(161, 141, 141, 1)),),
                            Text("Rp 8K", style: TextStyle(fontSize: 15, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 23,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _value = 2;
                      });
                    },
                    child: Container(
                      width: 84,
                      height: 69,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 206, 206, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(161, 141, 141, 1),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: _value == 2 ? Colors.blue : const Color.fromRGBO(196, 196, 196, 1),
                          width: 2,
                        )
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Text("M", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(161, 141, 141, 1)),),
                            Text("Rp 10K", style: TextStyle(fontSize: 15, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 23,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _value = 3;
                      });
                    },
                    child: Container(
                      width: 84,
                      height: 69,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 206, 206, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(161, 141, 141, 1),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: _value == 3 ? Colors.blue : const Color.fromRGBO(196, 196, 196, 1),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Text("L", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(161, 141, 141, 1)),),
                            Text("Rp 15K", style: TextStyle(fontSize: 15, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text(
                "Extra Toping",
                style: TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 10,),

              // Sebagai penghubung ke firestore
              StreamBuilder(
                stream: _menu.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    // Untuk menampilkan semua data di dalam database dalam bentuk grid view
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 230,
                      ), 
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // Untuk menghitung jumlah data
                      itemCount: streamSnapshot.data!.docs.length,
                      // Sebagai builder
                      itemBuilder: (context, index){
                        // Untuk mengambil data di index
                        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                        // Search Menu
                        return documentSnapshot["item"]
                          .toLowerCase()
                          .contains(searchString)
                        ? Card(
                          color: Colors.white,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15),),
                          ),
                          child: SizedBox(
                            child: InkWell(
                              splashColor: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        // Untuk mengambil data di field image
                                        documentSnapshot["image"],
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        // Untuk mengambil data di field item
                                        documentSnapshot["item"], 
                                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                      ),
                                      Text("+${documentSnapshot["price"]}K") // Mengambil data di field price
                                    ],
                                  )
                                ],
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  // Menambahkan data dari menu ke detail kebab
                                  if(_value == 1){
                                    return DetailKebab(
                                      email: widget.emailSend,
                                      detailToping: documentSnapshot["item"],
                                      detailPrice: documentSnapshot["price"] * 1000,
                                      detailImage: documentSnapshot["image"],
                                      totalPriceSize: 8000,
                                      typeSize: "S",
                                    );
                                  } else if(_value == 2){
                                    return DetailKebab(
                                      email: widget.emailSend,
                                      detailToping: documentSnapshot["item"],
                                      detailPrice: documentSnapshot["price"] * 1000,
                                      detailImage: documentSnapshot["image"],
                                      totalPriceSize: 10000,
                                      typeSize: "M",
                                    );
                                  } else if(_value == 3){
                                    return DetailKebab(
                                      email: widget.emailSend,
                                      detailToping: documentSnapshot["item"],
                                      detailPrice: documentSnapshot["price"] * 1000,
                                      detailImage: documentSnapshot["image"],
                                      totalPriceSize: 15000,
                                      typeSize: "L",
                                    );
                                  } else {
                                    return DetailKebab(
                                      email: widget.emailSend,
                                      detailToping: documentSnapshot["item"],
                                      detailPrice: documentSnapshot["price"] * 1000,
                                      detailImage: documentSnapshot["image"],
                                      totalPriceSize: 0,
                                      typeSize: "",
                                    );
                                  }
                                }));
                              },
                            ),
                          ),
                        ) : const SizedBox();
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}