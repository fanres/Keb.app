import 'package:flutter/material.dart';
import 'package:kebapp/view/auth/login.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key}) : super(key: key);
 
 static const routeName = "/splash_screen";
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(255, 0, 0, 1), Color.fromRGBO(229, 76, 120, 1)],
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 30,),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Keb.app", 
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 40,),
                    SizedBox(
                      width: 285,
                      height: 197,
                      child: Image.asset("assets/images/kebab.png"),
                    ),
                  ],
                ),
              ),
              Card(
                color: const Color.fromRGBO(244, 201, 201, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: SizedBox(
                  width: 170,
                  height: 34,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));
                    },
                    child: const Center(
                      child: Text("Get Started ...", style: TextStyle(fontSize: 18, color: Color.fromRGBO(238, 41, 41, 1)),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}