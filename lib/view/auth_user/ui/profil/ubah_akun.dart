// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import "dart:io";
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kebapp/view/auth_user/ui/profil/alamat.dart';
import "package:path/path.dart";

class UbahAkun extends StatefulWidget{
  UbahAkun({Key? key, required this.emailSend}) : super(key: key);
  static const routeName = "/ubah_akun";
  late String emailSend;

  @override
  State<UbahAkun> createState() => _UbahAkun();
}

class _UbahAkun extends State<UbahAkun>{
  final CollectionReference _userAkun = FirebaseFirestore.instance.collection("akun_user");

  File? _image;
  final pickerImage = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;

  // Mengambil gambar
  Future pickImage(ImageSource source) async {
    try {
      final imagePicked = await ImagePicker().pickImage(source: source);
      setState(() {
        if(pickerImage != null){
          _image = File(imagePicked!.path);
          print("Success Change Profile Image");
        } else {
          print("No Image Selected");
        }
      });
    } on PlatformException catch(e) {
      print("Failed to connect in gallery : $e");
    }
  }

  // Upload gambar ke storage
  Future<String> uploadImage(File imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName = basename(imageFile.path);
    Reference ref = storage.ref().child(fileName);
    UploadTask task = ref.putFile(imageFile);
    TaskSnapshot snapshot = await task.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }

  // Mengambil gambar dari database ke firestore
  Future getDownloadImage(String imageName) async {
    String downloadURL = await storage.ref().getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: const Text("Ubah Akun", style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: _userAkun.where("email", isEqualTo: widget.emailSend).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 22,),
                  Stack(
                    children: [
                      InkWell(
                        splashColor: Colors.grey,
                        onTap: (){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return Dialog(
                                child: Container(
                                  width: 400,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: _image != null ? FileImage(_image!)
                                        : snapshot.data!.docs[0]["uploadImage"] != true 
                                        ? AssetImage(snapshot.data!.docs[0]["image"]) as ImageProvider
                                        : NetworkImage(snapshot.data!.docs[0]["image"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                          );
                        },
                        child: Container(
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
                              image: _image != null ? FileImage(_image!)
                                : snapshot.data!.docs[0]["uploadImage"] != true 
                                ? AssetImage(snapshot.data!.docs[0]["image"]) as ImageProvider
                                : NetworkImage(snapshot.data!.docs[0]["image"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: (){
                            showModalBottomSheet(
                              context: context, 
                              builder: (builder){
                                return Container(
                                  color: const Color.fromRGBO(233, 206, 206, 1),
                                  height: 200,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.grey,
                                          onTap: (){
                                            pickImage(ImageSource.camera);
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.camera_enhance, size: 40,),
                                              Text("Kamera", style: TextStyle(fontSize: 18),)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 100,),
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.grey,
                                          onTap: (){
                                            pickImage(ImageSource.gallery);
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.photo, size: 40,),
                                              Text("Galeri", style: TextStyle(fontSize: 18),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.camera_enhance, color: Color.fromRGBO(227, 40, 96, 0.78),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 22, right: 22),
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
                                const Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                Text(snapshot.data!.docs[0]["nama"], style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
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
                                const Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                Text(snapshot.data!.docs[0]["username"], style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
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
                                const Text("No. Telp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                Text(snapshot.data!.docs[0]["telp"], style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
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
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Alamat(emailSend: widget.emailSend);
                                  }));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Alamat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                    Icon(Icons.arrow_right_sharp)
                                  ],
                                ),
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
                                const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                Text(snapshot.data!.docs[0]["email"], style: const TextStyle(fontSize: 16, color: Color.fromRGBO(161, 141, 141, 1)),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 76,),
                        Card(
                          color: const Color.fromRGBO(227, 40, 96, 0.78),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: SizedBox(
                            height: 50,
                            child: InkWell(
                              child: const Center(
                                child: Text("SIMPAN", style: TextStyle(color: Colors.white),),
                              ),
                              onTap: () async {
                                try {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Berhasil Disimpan")));
                                  
                                  // Menyimpan gambar ke storage firebase
                                  String fileName = basename(_image!.path);
                                  Reference ref = storage.ref().child(fileName);
                                  UploadTask task = ref.putFile(_image!);
                                  TaskSnapshot taskSnapshot = await task.whenComplete(() => null);
                                  String downloadURL = await taskSnapshot.ref.getDownloadURL();
                                           
                                  // Mengupdate data ke tabel akun_user
                                  await _userAkun.doc(snapshot.data!.docs[0].id).update({
                                    "image": downloadURL,
                                    "uploadImage": true
                                  });
                                } catch(e) {
                                  print(e.toString());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

