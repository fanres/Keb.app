import 'package:flutter/material.dart';
import 'package:kebapp/view/auth/login.dart';
import 'package:kebapp/view/auth/lupa_katasandi.dart';
import 'package:kebapp/view/auth/register.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/keranjang.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/order.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/order_done.dart';
import 'package:kebapp/view/auth_user/ui/keranjang/order_on_progress.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        LupaKataSandi.routeName: (context) => const LupaKataSandi(),
        MyBottomNavigationBar.routeName: (context) => MyBottomNavigationBar(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        Menu.routeName: (context) => Menu(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        Keranjang.routeName: (context) => Keranjang(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        MyProfile.routeName: (context) => MyProfile(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        UbahAkun.routeName: (context) => UbahAkun(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        Riwayat.routeName: (context) => Riwayat(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        TentangKami.routeName: (context) => const TentangKami(),
        DetailKebab.routeName: (context) => DetailKebab(
          email: ModalRoute.of(context)?.settings.arguments as String,
          detailImage: ModalRoute.of(context)?.settings.arguments as String,
          detailPrice: ModalRoute.of(context)?.settings.arguments as int,
          detailToping: ModalRoute.of(context)?.settings.arguments as String,
          totalPriceSize: ModalRoute.of(context)?.settings.arguments as int,
          typeSize: ModalRoute.of(context)?.settings.arguments as String,
        ),
        Alamat.routeName: (context) => Alamat(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
        AlamatBaru.routeName: (context) => AlamatBaru(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
          indexAlamat: ModalRoute.of(context)?.settings.arguments as int,
          nama: ModalRoute.of(context)?.settings.arguments as String,
          nomor: ModalRoute.of(context)?.settings.arguments as String,
          jalan: ModalRoute.of(context)?.settings.arguments as String,
        ),
        GoogleMapsScreen.routeName: (context) => GoogleMapsScreen(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
          indexAlamat: ModalRoute.of(context)?.settings.arguments as int,
        ),
        Order.routeName: (context) => Order(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
          countItem: ModalRoute.of(context)?.settings.arguments as int,
        ),
        OrderOnProgress.routeName: (context) => OrderOnProgress(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
          latitude: ModalRoute.of(context)?.settings.arguments as double,
          longitude: ModalRoute.of(context)?.settings.arguments as double,
        ),
        OrderComplete.routeName: (context) => OrderComplete(
          emailSend: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}

