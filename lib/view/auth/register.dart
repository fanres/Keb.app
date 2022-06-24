import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "/register_page";

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();
  final nNameController = TextEditingController();
  final nUsernameController = TextEditingController();
  final nTelpController = TextEditingController();
  final nEmailController = TextEditingController();
  final nPasswordController = TextEditingController();
  final nRetypePasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _userAkun = FirebaseFirestore.instance.collection("akun_user");

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              width: 560,
              height: 576,
              left: -129,
              top: -288,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/kebab2.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                      color: Color.fromRGBO(238, 41, 41, 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 100,),
                  const Text("Keb.app", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 70,),
                  Container(
                    width: 307,
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(243, 234, 234, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 13,),
                        const Text("Daftar", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 23, right: 23),
                            child: Column(
                              children: [
                                const SizedBox(height: 32,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: nNameController,
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
                                const SizedBox(height: 17,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: nUsernameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Username",
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
                                const SizedBox(height: 17,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: nTelpController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "No. Telepon",
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
                                const SizedBox(height: 17,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: nEmailController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Email",
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
                                const SizedBox(height: 17,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    } else if (value.length < 6) {
                                      return "Minimal 6 karakter";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  obscureText: true,
                                  controller: nPasswordController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Password",
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
                                const SizedBox(height: 17,),
                                TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return 'Isi dengan benar!!!';
                                    } else if (value != nPasswordController.text) {
                                      return "Tidak sama dengan Password";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  obscureText: true,
                                  controller: nRetypePasswordController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Retype Password",
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
                                const SizedBox(height: 40,),
                                Card(
                                  color: const Color.fromRGBO(227, 40, 96, 0.78),
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: SizedBox(
                                    width: 163,
                                    height: 39,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      child: const Center(
                                        child: Text("DAFTAR", style: TextStyle(fontSize: 18, color: Colors.white),),
                                      ),
                                      onTap: () async {
                                        if(_formKey.currentState!.validate()) {
                                          _userAkun.add({
                                            "nama": nNameController.text,
                                            "username": nUsernameController.text,
                                            "telp": nTelpController.text,
                                            "email": nEmailController.text.toLowerCase(),
                                            "image": "assets/images/blank-profile.png",
                                            "uploadImage": false,
                                            "create_address": false
                                          });

                                          _auth.createUserWithEmailAndPassword(email: nEmailController.text.toLowerCase(), password: nPasswordController.text);
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Akun Anda berhasil ditambahkan")));

                                          nNameController.text = "";
                                          nUsernameController.text = "";
                                          nTelpController.text = "";
                                          nEmailController.text = "";
                                          nPasswordController.text = "";
                                          nRetypePasswordController.text = "";

                                          Navigator.of(context).pushNamedAndRemoveUntil('/login_page', (Route<dynamic> routeName) => false);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 9,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Sudah punya akun?", style: TextStyle(fontSize: 13, color: Color.fromRGBO(161, 141, 141, 1)),),
                                    const SizedBox(width: 5,),
                                    InkWell(
                                      child: const Text("Log In", style: TextStyle(fontSize: 13, color: Color.fromRGBO(238, 41, 41, 0.7)),),
                                      onTap: (){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/login_page', (Route<dynamic> routeName) => false);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 35,),
                              ],
                            ),
                          ),
                        ),
                      ],
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