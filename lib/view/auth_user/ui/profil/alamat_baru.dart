import "package:flutter/material.dart";

class AlamatBaru extends StatefulWidget{
  AlamatBaru({Key? key}) : super(key: key);
  static const routeName = "/alamat_baru";

  @override
  State<AlamatBaru> createState() => _AlamatBaru();
}

class _AlamatBaru extends State<AlamatBaru>{
  final nameController = TextEditingController();
  final nomorController = TextEditingController();
  late String nName, nNomor;

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
        title: const Text("Alamat Baru", style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Kontak"),
                    TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Isi dengan benar!!!';
                        }
                        return null;
                      },
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
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Isi dengan benar!!!';
                        }
                        return null;
                      },
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
                    const Text("Alamat"),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: (){
                        Navigator.pushNamed(context, "/google_maps");
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
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Isi dengan benar!!!';
                        }
                        return null;
                      },
                      autofocus: false,
                      controller: nomorController,
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
        ],
      ),
    );
  }
}