import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool passwordFlag = true;
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
void createUser()async{
  String name=nameController.text.trim();
  String email=emailController.text.trim();
  String password=passwordController.text.trim();
  if(!_formkey.currentState!.validate()){
    return;
  }
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
FirebaseFirestore.instance.collection("user").add({"name":name,"uid":userCredential.user?.uid,"email":userCredential.user?.email});
if(userCredential.user!=null){
  Navigator.pop(context);
}
    //userCredential.user?.updateDisplayName(name,);
   // print(userCredential.user?.displayName);
  } on FirebaseAuthException catch(e){
    var snackBar = SnackBar(
      content: Text(e.code.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 0.1 * width, vertical: 0.2 * height),
          decoration: BoxDecoration(),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text("Create Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                  validator: MultiValidator([RequiredValidator(errorText: "Password Required "),
                    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),]),
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
                SizedBox(
                    width: 0.7 * width,
                    child: ElevatedButton(
                        onPressed: () {
createUser();
                        }, child: const Text("Sign up"))),
                const Text("or"),
                SizedBox(
                  width: 0.7 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white24),
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
}
