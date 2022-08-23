import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marshall_marketing/signIn_screen.dart';

import 'SignUp_screen.dart';
import 'displaySocietyForm_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";

  late DocumentSnapshot documentSnapshot;
  late QuerySnapshot querySnapshot;
  File? image;
  bool pickImageFlag = false;
  bool circleAvatarImageFlag = false;
  bool mainCircleAvatar = true;
  bool updateImage = false;
  String url = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      loadFirstData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FirebaseAuth.instance.currentUser == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    },
                    child: const Text("Login"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text("Create account"),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: mainCircleAvatar
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      padding: const EdgeInsets.only(top: 0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 0.3700 * width,
                                ),
                                SizedBox(
                                  height: 0.2 * height,
                                ),
                                CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: circleAvatarImageFlag
                                        ? NetworkImage(url)
                                        : null,
                                    child: circleAvatarImageFlag
                                ? null
                                    : const Icon(Icons.person),
                                   ),
                                updateImage
                                    ? const CircularProgressIndicator()
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            pickImageFlag = !pickImageFlag;
                                          });
                                        },
                                        icon: Icon(Icons.edit_outlined,
                                            color: pickImageFlag
                                                ? Colors.black
                                                : Colors.black12)),
                                pickImageFlag
                                    ? const Text("")
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 28.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  pickImageFromGallery();
                                                },
                                                icon: const Icon(
                                                    Icons.image_outlined)),
                                            IconButton(
                                                onPressed: () {
                                                  pickImageFromCamera();
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt_outlined)),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 0.05 * height,
                            ),
                            Column(
                              children: [
                                Center(
                                    child: Text(
                                  "Hello ${documentSnapshot['name']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                                Container(
                                  width: width,
                                  height: (70 * querySnapshot.docs.length)
                                      .toDouble(),
                                  child: ListView.builder(
                                      itemCount: querySnapshot.docs.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(Icons.file_copy),
                                          title: Text(querySnapshot.docs[index]
                                              ['nameApplicant']),
                                          subtitle: Text(querySnapshot
                                              .docs[index]['date']),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowSocietyForm(
                                                          showForm:
                                                              querySnapshot
                                                                  .docs[index],
                                                        )));
                                          },
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
            ),
    );
  }

  Future pickImageFromGallery() async {
    try {
      XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (xFile == null) return;
      image = File(xFile.path);

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profileImage")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .putFile(image!);
      setState(() {
        pickImageFlag = !pickImageFlag;
        updateImage = true;
        circleAvatarImageFlag = true;
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String path = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"profileImage": path});
      DocumentSnapshot localShanpShot = await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      url = localShanpShot['profileImage'];
      setState(() {
        updateImage = false;
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code.toString()),
      ));
    }
  }

  Future pickImageFromCamera() async {
    try {
      XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (xFile == null) return;
      image = File(xFile.path);

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profileImage")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .putFile(image!);
      setState(() {
        pickImageFlag = !pickImageFlag;
        updateImage = true;
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String path = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"profileImage": path});
      DocumentSnapshot localShanpShot = await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      url = localShanpShot['profileImage'];
      setState(() {
        updateImage = false;
        // pickImageFlag = !pickImageFlag;
      });
    } on FirebaseException catch (e) {}
  }

  Future loadFirstData() async {
    try {
      documentSnapshot = await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      querySnapshot = await FirebaseFirestore.instance
          .collection("societyForm")
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
      mainCircleAvatar = false;
      url = documentSnapshot['profileImage'];

      if (url != null) {
        circleAvatarImageFlag = true;
        pickImageFlag = !pickImageFlag;
      }

      setState(() {});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code.toString()),
      ));
    }

    // await  FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid).get();
  }
}
