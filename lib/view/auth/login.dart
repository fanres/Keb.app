
import 'package:flutter/material.dart';
import 'package:kebapp/view/auth/lupa_katasandi.dart';
import 'package:kebapp/view/auth/register.dart';
import 'package:kebapp/view/widget/bottom_navbar.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "/login_page";

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final nUsernameController = TextEditingController();
  final nPasswordController = TextEditingController();
  late String nUsername, nPassword;

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
                    height: 507,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(243, 234, 234, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 13,),
                        const Text("Log in", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),),
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
                                  controller: nUsernameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: "Enter email or username",
                                    labelStyle: TextStyle(color: Color.fromRGBO(161, 141, 141, 1)),
                                    hintText: "Email or Username",
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
                                  obscureText: true,
                                  controller: nPasswordController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Color.fromRGBO(161, 141, 141, 1)),
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
                                const SizedBox(height: 27,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    child: const Text("Lupa kata sandi?", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return LupaKataSandi();
                                      }));
                                    },
                                  ),
                                ),
                                const SizedBox(height: 55,),
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
                                        child: Text("LOG IN", style: TextStyle(fontSize: 18, color: Colors.white),),
                                      ),
                                      onTap: (){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          
                                          return MyBottomNavigationBar();
                                        }));
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 9,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Belum punya akun?", style: TextStyle(fontSize: 13, color: Color.fromRGBO(161, 141, 141, 1)),),
                                    const SizedBox(width: 5,),
                                    InkWell(
                                      child: const Text("Daftar", style: TextStyle(fontSize: 13, color: Color.fromRGBO(238, 41, 41, 0.7)),),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return RegisterPage();
                                        }));
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24,),
                                const Text("Or", style: TextStyle(fontSize: 14, color: Color.fromRGBO(161, 141, 141, 1)),),
                                const SizedBox(height: 24,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: const CircleBorder(),
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          child: Image.asset("assets/images/google.png"),
                                          onTap: (){},
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4,),
                                    Card(
                                      elevation: 5,
                                      shape: const CircleBorder(),
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          child: Image.asset("assets/images/facebook.png"),
                                          onTap: (){},
                                        ),
                                      ),
                                    ),
                                  ],
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
            )
          ],
        ),
      ),
    );
  }
}