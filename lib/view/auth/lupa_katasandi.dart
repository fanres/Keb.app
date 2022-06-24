import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LupaKataSandi extends StatefulWidget{
  const LupaKataSandi({Key? key}) : super(key: key);
  static const routeName = "/forget_password";

  @override
  State<LupaKataSandi> createState() => _LupaKataSandi();
}

class _LupaKataSandi extends State<LupaKataSandi>{
  final _formKey = GlobalKey<FormState>();
  final nEmailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                        const Text("Lupa Kata Sandi", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 23, right: 23),
                            child: Column(
                              children: [
                                const SizedBox(height: 52,),
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
                                const SizedBox(height: 50,),
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
                                        child: Text("Send Request", style: TextStyle(fontSize: 18, color: Colors.white),),
                                      ),
                                      onTap: (){
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            // Merubah password
                                            _auth.sendPasswordResetEmail(email: nEmailController.text.toLowerCase());
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Silakan Cek Email Anda")));
                                            Navigator.of(context).pushNamedAndRemoveUntil('/login_page', (Route<dynamic> routeName) => false);
                                          } catch(e) {
                                            print(e.toString());
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Silakan Coba Lagi")));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40,),
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