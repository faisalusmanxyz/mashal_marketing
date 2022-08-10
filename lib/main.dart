import 'package:flutter/material.dart';
import 'package:marshall_marketing/prictac.dart';
import 'home_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Marshall_Marketing',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:const HomeScreen()

    );
  }
}




