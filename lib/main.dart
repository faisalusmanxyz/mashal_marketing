import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marshall_marketing/signIn_screen.dart';

import 'SignUp_screen.dart';
import 'home_screen.dart';

void main()async {
  try{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  }catch(e){print(e.toString());}
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "signup":(context)=>const SignUpScreen(),
        "login":(context)=>const SignInScreen(),
        "home":(context)=>const HomeScreen()
      },
      debugShowCheckedModeBanner: false,
      title: 'Marshall_Marketing',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:const HomeScreen()

    );
  }
}




