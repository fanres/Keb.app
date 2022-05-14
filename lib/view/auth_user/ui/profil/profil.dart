import "package:flutter/material.dart";
import 'package:kebapp/view/auth_user/ui/profil/riwayat.dart';
import 'package:kebapp/view/auth_user/ui/profil/tentang_kami.dart';
import 'package:kebapp/view/auth_user/ui/profil/ubah_akun.dart';
import 'package:kebapp/data.dart';

class MyProfile extends StatelessWidget{
  const MyProfile({Key? key}) : super(key: key);
  static const routeName = "/profil";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: const Text("Akun", style: TextStyle(color: Colors.black),),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 68,
                        height: 68,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            Data().username,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            "ilhamgod123@gmail.com",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(161, 141, 141, 1)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40,),
                      InkWell(
                        splashColor: Colors.white,
                        child: const Icon(Icons.text_fields),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return UbahAkun();
                          }));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17,),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Riwayat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          InkWell(
                            splashColor: Colors.grey,
                            child: const Icon(Icons.double_arrow, color: Colors.grey,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Riwayat();
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tentang Kami", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          InkWell(
                            splashColor: Colors.grey,
                            child: const Icon(Icons.double_arrow, color: Colors.grey,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return TentangKami();
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          InkWell(
                            splashColor: Colors.grey,
                            child: const Icon(Icons.double_arrow, color: Colors.grey,),
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}