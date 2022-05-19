import "package:flutter/material.dart";

class Alamat extends StatefulWidget{
  Alamat({Key? key}) : super(key: key);
  static const routeName = "/alamat";

  @override
  State<Alamat> createState() => _Alamat();
}
class _Alamat extends State<Alamat>{
  int _value = 0;
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
      body: _value == 0 ? InkWell(
        splashColor: Colors.grey,
        onTap: (){
          Navigator.pushNamed(context, "/alamat_baru");
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
      ) : Column(),
    );
  }
}