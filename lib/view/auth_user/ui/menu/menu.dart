import 'package:flutter/material.dart';
import "dart:io";
import 'package:kebapp/data.dart';

class Menu extends StatefulWidget{
  const Menu({Key? key}) : super(key: key);
  static const routeName = "/menu";

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu>{
  late TextEditingController? searchController = TextEditingController();
  late String searchString = "";
  bool isSearching = false;
  int _value = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: Row(
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
                  image: AssetImage(Data().imageProfile),
                  fit: BoxFit.cover
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Text.rich(
              TextSpan(
                text: "Hai, ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: Data().username,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    )
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
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
              Form(
                child: TextFormField(
                  autofocus: false,
                  controller: searchController,
                  onChanged: (value){
                    searchString = value.toLowerCase();
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
              const SizedBox(height: 10,),
              const Text(
                "Extra Toping",
                style: TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}