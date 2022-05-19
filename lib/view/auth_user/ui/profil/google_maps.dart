import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget{
  GoogleMapsScreen({Key? key}) : super(key: key);
  static const routeName = "/google_maps"; 

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreen();
}
class _GoogleMapsScreen extends State<GoogleMapsScreen>{
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text("Alamat Baru", style: TextStyle(color: Colors.black),),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-8.058543, 111.848920),
          zoom: 15,
        ),
      ),
    );
  }
}
