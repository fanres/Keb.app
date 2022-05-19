import 'package:flutter/material.dart';
import 'package:kebapp/view/auth/login.dart';
import 'package:kebapp/view/auth/lupa_katasandi.dart';
import 'package:kebapp/view/auth/register.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/keranjang.dart';
import 'package:kebapp/view/auth_user/ui/menu/detail_kebab.dart';
import 'package:kebapp/view/auth_user/ui/menu/menu.dart';
import 'package:kebapp/view/auth_user/ui/profil/alamat.dart';
import 'package:kebapp/view/auth_user/ui/profil/alamat_baru.dart';
import 'package:kebapp/view/auth_user/ui/profil/google_maps.dart';
import 'package:kebapp/view/auth_user/ui/profil/profil.dart';
import 'package:kebapp/view/auth_user/ui/profil/riwayat.dart';
import 'package:kebapp/view/auth_user/ui/profil/tentang_kami.dart';
import 'package:kebapp/view/auth_user/ui/profil/ubah_akun.dart';
import 'package:kebapp/view/splash_screen/splash_screen.dart';
import 'package:kebapp/view/widget/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keb.app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        LupaKataSandi.routeName: (context) => LupaKataSandi(),
        MyBottomNavigationBar.routeName: (context) => const MyBottomNavigationBar(),
        Menu.routeName: (context) => Menu(),
        Keranjang.routeName: (context) => Keranjang(),
        MyProfile.routeName: (context) => MyProfile(),
        UbahAkun.routeName: (context) => UbahAkun(),
        Riwayat.routeName: (context) => Riwayat(),
        TentangKami.routeName: (context) => TentangKami(),
        DetailKebab.routeName: (context) => DetailKebab(
              detailImage: ModalRoute.of(context)?.settings.arguments as String,
              detailPrice: ModalRoute.of(context)?.settings.arguments as int,
              detailToping:ModalRoute.of(context)?.settings.arguments as String,
              totalPriceSize: ModalRoute.of(context)?.settings.arguments as int,
              typeSize: ModalRoute.of(context)?.settings.arguments as String,
            ),
        Alamat.routeName: (context) => Alamat(),
        AlamatBaru.routeName: (context) => AlamatBaru(),
        GoogleMapsScreen.routeName: (context) => GoogleMapsScreen(),
      },
    );
  }
}
