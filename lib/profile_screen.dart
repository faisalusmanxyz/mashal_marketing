import 'dart:io';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marshall_marketing/signIn_screen.dart';

import 'SignUp_screen.dart';
import 'displaySocietyForm_screen.dart';
import 'entity/usermessage_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController messageController = TextEditingController();
  String name = "";
  final GlobalKey<FormState> _formKey = GlobalKey();
  late DocumentSnapshot documentSnapshot;
  late QuerySnapshot querySnapshot;
  File? image;
  bool pickImageFlag = false;
  bool circleAvatarImageFlag = false;
  bool mainCircleAvatar = true;
  bool updateImage = false;
  String url = "";
  bool disableButton = false;
  bool contactUsFlag=false;

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
                  ? SizedBox(
                      height: 0.5 * height,
                      child: const Center(child: CircularProgressIndicator()))
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
                                Stack(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15),
                                        child: Container(
                                          width: 1 * width,
                                          height: 0.3 * height,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueAccent)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.02 * height,
                                          left: 0.06 * width),
                                      child: Icon(Icons.message),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0.150 * width),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                            hintText: "Contact Us",
                                            hintStyle: TextStyle(fontSize: 20),
                                            //label: Text("Contact Us"),
                                            border: InputBorder.none),
                                        maxLines: 6,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            disableButton = true;
                                          } else {
                                            disableButton = false;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                contactUsFlag? Padding(
                                  padding:    EdgeInsets.only(left: 0.67000 * width,top: 1),
                                  child: const CircularProgressIndicator(),
                                ) : Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.67000 * width),
                                  child: ElevatedButton(
                                      onPressed:
                                          disableButton ? saveMassage : null,
                                      child: const Text("Send")),
                                ),
                                Builder(builder: (context) {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 0.2 * height,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("Logout")),
                                      ],
                                    );
                                  }
                                  return const Text("");
                                }),
                                SizedBox(height: 0.05*height,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
      name=documentSnapshot['name'];

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

  void saveMassage()async {
    setState(() {
      contactUsFlag=true;
    });
    try {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;


      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      String signature = packageInfo.buildSignature;
      String message = messageController.text;
      Map<String, dynamic> packageIn = {
        "appName": appName,
        "version": version,
        "buildNumber": buildNumber,
        "signature": signature
      };
      String uid = FirebaseAuth.instance.currentUser!.uid;
      UserMessageModel userMessageModel = UserMessageModel(date: date,
          userName: name,
          uid: uid,
          message: message,
          packageInfo: packageIn,
          deviceInfo: androidInfo.toMap());
     await UserMessageModel.collection().add(userMessageModel);
     messageController.clear();
     setState(() {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text('Message successfully stored'),
       ));
       contactUsFlag=false;
       disableButton=false;
     });
    }catch(e){

    }
  }
}
