// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter_polyline_points/flutter_polyline_points.dart";
import 'package:kebapp/view/auth_user/ui/keranjang/order_done.dart';

class OrderOnProgress extends StatefulWidget {
  OrderOnProgress({Key? key, required this.emailSend, required this.latitude, required this.longitude}) : super(key: key);
  static const routeName = "/order_on_progress";
  late String emailSend;
  late double latitude;
  late double longitude;

  @override
  State<OrderOnProgress> createState() => _OrderOnProgress();
}

class _OrderOnProgress extends State<OrderOnProgress> {
  final CollectionReference _alamatUser = FirebaseFirestore.instance.collection("alamat_user");
  GoogleMapController? _controller;

  List<LatLng> polylineCoordinates = [];

  void _getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCsMqGGweEHQwQdQukHllLRie4oJiZYXrI", 
      const PointLatLng(-8.164091, 113.713072), 
      PointLatLng(widget.latitude, widget.longitude)
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) { 
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _getPolyPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text("Pesanan Anda", style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return OrderComplete(emailSend: widget.emailSend,);
              }), (route) => false);
            }, 
            child: const Text("Selesai", style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _alamatUser.where("email", isEqualTo: widget.emailSend).where("aktif", isEqualTo: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!.docs[0]["latitude"], snapshot.data!.docs[0]["longitude"]),
                    zoom: 15
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  zoomControlsEnabled: true,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: polylineCoordinates,
                      color: Colors.blue,
                      width: 4,
                      visible: true
                    )
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("My Location"),
                      position: LatLng(snapshot.data!.docs[0]["latitude"], snapshot.data!.docs[0]["longitude"]),
                    ),
                    const Marker(
                      markerId: MarkerId("Driver Location"),
                      position: LatLng(-8.164091, 113.713072),
                    )
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    onPressed: () async {
                      _controller?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(snapshot.data!.docs[0]["latitude"], snapshot.data!.docs[0]["longitude"]), 
                            zoom: 17
                          )
                        )
                      );
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.my_location_outlined, color: Colors.blue,),
                  ),
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