import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'entity/society_model.dart';

class SignUpScreen extends StatefulWidget {
  final SocietyModel socityModelobj;
  const SignUpScreen({Key? key,required this.socityModelobj}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passwordFlag = true;
  bool confirmPasswordFlag = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 0.1 * width, vertical: 0.2 * height),
          decoration: const BoxDecoration(),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text("Create Account",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 0.04 * height,
                ),
                Text(
                  passError,
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(
                  height: 0.04 * height,
                ),
                TextFormField(
                  controller: nameController,
                  validator: RequiredValidator(errorText: "username Required"),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "username",
                  ),
                ),
                SizedBox(
                  height: 0.04 * height,
                ),
                TextFormField(
                  controller: emailController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Email field is Required"),
                    EmailValidator(errorText: "Invalid Email")
                  ]),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 0.04 * height,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Password Required "),
                    MinLengthValidator(8,
                        errorText: 'password must be at least 8 digits long'),
                  ]),
                  controller: passwordController,
                  obscureText: passwordFlag,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordFlag = !passwordFlag;
                          });
                        },
                        icon: passwordFlag
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      )),
                ),
                SizedBox(
                  height: 0.04 * height,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Confirm Password Required "),
                    MinLengthValidator(8,
                        errorText: 'password must be at least 8 digits long'),
                  ]),
                  controller: confirmpasswordController,
                  obscureText: confirmPasswordFlag,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordFlag = !confirmPasswordFlag;
                          });
                        },
                        icon: confirmPasswordFlag
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      )),
                ),
                SizedBox(
                  height: 0.02 * height,
                ),
                SizedBox(
                    width: 0.7 * width,
                    child: ElevatedButton(
                        onPressed: () {
                          createUser();
                        },
                        child: const Text("Sign up"))),
                const Text("or"),
                SizedBox(
                  width: 0.7 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white24),
                    ),
                    child: const Text("Log in"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String passError = "";

  void createUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmpasswordController.text.trim();
    if (!_formkey.currentState!.validate()) {
      setState(() {
        passError = "";
      });
      return;
    }
    if (confirmPassword != password) {
      passError = "Invalid Confirm Password";
      setState(() {});
      return;
    }
    passError = "";
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance.collection("user").add({
        "name": name,
        "uid": userCredential.user?.uid,
        "email": userCredential.user?.email
      });

      if (userCredential.user != null) {
        widget.socityModelobj.uid=FirebaseAuth.instance.currentUser!.uid;
        SocietyModel.collection().add(widget.socityModelobj);
        var snackBar = const SnackBar(
          content: Text("Successfully account created"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
       Navigator.pushNamed(context, 'home');
      }
      //userCredential.user?.updateDisplayName(name,);
      // print(userCredential.user?.displayName);
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: Text(e.code.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
