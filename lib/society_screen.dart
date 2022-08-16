import 'package:flutter/material.dart';

class SocietyScreen extends StatefulWidget {
  const SocietyScreen({Key? key}) : super(key: key);

  @override
  State<SocietyScreen> createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen> {
  String cnic = "";



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("hello")),
    );
  }

  void validate() {
    RegExp regexp = RegExp("^[0-9]{5}-[0-9]{7}-[0-9]");
    if (regexp.hasMatch(cnic)) {
      print("validate cnic");
    } else {
      print("no match cnic");
    }
  }
}
