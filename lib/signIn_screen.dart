import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignUp_screen.dart';
import 'entity/society_model.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  final SocietyModel? societyModelObj;

  SignInScreen({Key? key, this.societyModelObj}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final SocietyModel socityModelObj;
  bool passwordFlag = true;
  var fromKey = GlobalKey<FormState>();
  String error = "";

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
            key: fromKey,
            child: Column(
              children: [
                const Text("Login",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 0.05 * height,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 0.04 * height,
                ),
                TextFormField(
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
                  height: 0.02 * height,
                ),
                Text(
                  error,
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(
                  height: 0.02 * height,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password",
                    ),
                  ),
                ),
                SizedBox(
                    width: 0.7 * width,
                    child: ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
                        child: const Text("Login"))),
                const Text("or"),
                SizedBox(
                  width: 0.7 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                  societyModelObj: widget.societyModelObj,
                                )),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white24),
                    ),
                    child: const Text("Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null && widget.societyModelObj != null) {
        widget.societyModelObj!.uid = FirebaseAuth.instance.currentUser!.uid;
        SocietyModel.collection().add(widget.societyModelObj!);

        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (userCredential.user != null &&
          widget.societyModelObj == null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseException catch (e) {
      error = e.code.toString();
      setState(() {});
      print(e.code.toString());
    }
  }
}
