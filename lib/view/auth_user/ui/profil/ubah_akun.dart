// ignore_for_file: unnecessary_null_comparison

import "dart:io";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:kebapp/data.dart';
import 'package:image_picker/image_picker.dart';

class UbahAkun extends StatefulWidget {
  UbahAkun({Key? key}) : super(key: key);
  static const routeName = "/ubah_akun";

  @override
  State<UbahAkun> createState() => _UbahAkun();
}

class _UbahAkun extends State<UbahAkun> {
  File? _image;
  final pickerImage = ImagePicker();

  Future pickImage(ImageSource source) async {
    try {
      final imagePicked = await ImagePicker().pickImage(source: source);
      setState(() {
        if (pickerImage != null) {
          _image = File(imagePicked!.path);
          print("Success Change Profile Image");
        } else {
          print("No Image Selected");
        }
      });
    } on PlatformException catch (e) {
      print("Failed to connect in gallery : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromRGBO(233, 206, 206, 1),
        elevation: 1,
        title: const Text(
          "Ubah Akun",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 22,
            ),
            Stack(
              children: [
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _image != null
                                      ? FileImage(_image!) as ImageProvider
                                      : AssetImage(Data().imageProfile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(120)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.54),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      image: DecorationImage(
                        image: _image != null
                            ? FileImage(_image!) as ImageProvider
                            : AssetImage(Data().imageProfile),
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (builder) {
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
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.camera_enhance,
                                            size: 40,
                                          ),
                                          Text(
                                            "Kamera",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.photo,
                                            size: 40,
                                          ),
                                          Text(
                                            "Galeri",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                    child: const Icon(
                      Icons.camera_enhance,
                      color: Color.fromRGBO(227, 40, 96, 0.78),
                    ),
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
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                            right: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nama",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            Data().username,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(161, 141, 141, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                            right: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "No. Telp",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            Data().username,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(161, 141, 141, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                            right: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.pushNamed(context, "/alamat");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Alamat",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              Data().username,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(161, 141, 141, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                            right: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            Data().username,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(161, 141, 141, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 76,
                  ),
                  Card(
                    color: const Color.fromRGBO(227, 40, 96, 0.78),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: SizedBox(
                      height: 50,
                      child: InkWell(
                        child: const Center(
                          child: Text(
                            "SIMPAN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
