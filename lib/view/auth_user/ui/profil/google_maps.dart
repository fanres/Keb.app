// ignore_for_file: must_be_immutable

import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:geolocator/geolocator.dart";
import "package:geocoding/geocoding.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleMapsScreen extends StatefulWidget{
  GoogleMapsScreen({Key? key, required this.emailSend, required this.indexAlamat}) : super(key: key);
  static const routeName = "/google_maps"; 
  late String emailSend;
  late int indexAlamat;

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreen();
}
class _GoogleMapsScreen extends State<GoogleMapsScreen>{
  String address = "";
  String desaKelurahan = "";
  String kecamatan = "";
  String kabupatenKota = "";
  String provinsi = "";
  String kodePos = "";
  String negara = "";
  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;

  LatLng onClick = const LatLng(0, 0);

  final CollectionReference _alamatUser = FirebaseFirestore.instance.collection("alamat_user");

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    address = '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
    desaKelurahan = place.subLocality.toString();
    kecamatan = place.locality.toString();
    kabupatenKota = place.subAdministrativeArea.toString();
    provinsi = place.administrativeArea.toString();
    kodePos = place.postalCode.toString();
    negara = place.country.toString();
  }

  @override
  void initState() {
    super.initState();
  }

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
      body: StreamBuilder(
        stream: _alamatUser.where("email", isEqualTo: widget.emailSend).where("id", isEqualTo: widget.indexAlamat).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-8.058705, 111.846598),
                    zoom: 5,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId("Point"),
                      position: onClick,
                    ),
                  },
                  onTap: (LatLng point) async {
                    List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
                    Placemark place = placemarks[0];
                    address = '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
                    desaKelurahan = place.subLocality.toString();
                    kecamatan = place.locality.toString();
                    kabupatenKota = place.subAdministrativeArea.toString();
                    provinsi = place.administrativeArea.toString();
                    kodePos = place.postalCode.toString();
                    negara = place.country.toString();
                    setState(() {
                      onClick = point;
                      latitude = point.latitude;
                      longitude = point.longitude;
                    });
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        onPressed: () async {
                          Position pos = await _getGeoLocationPosition();
                          getAddressFromLatLong(pos);
                          _controller?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 17)
                            )
                          );
                          setState(() {
                            latitude = pos.latitude;
                            longitude = pos.longitude;
                          });
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.my_location_outlined, color: Colors.blue,),
                      ),
                    ),
                    Card(
                      color: const Color.fromRGBO(227, 40, 96, 0.78),
                      elevation: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: const Center(
                            child: Text("Selesai", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          onTap: () async {
                            if (address != "") {
                              await _alamatUser.doc(snapshot.data!.docs[0].id).update({
                                "alamat_lengkap": address,
                                "desa_kelurahan": desaKelurahan,
                                "kecamatan": kecamatan,
                                "kabupaten_kota": kabupatenKota,
                                "provinsi": provinsi,
                                "kode_pos": kodePos,
                                "negara": negara,
                                "latitude": latitude,
                                "longitude": longitude
                              });
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Alamat Berhasil Tersimpan")));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Alamat Anda Masih Kosong")));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
