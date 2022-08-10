import 'package:flutter/material.dart';
import 'package:pk_cnic_input_field/pk_cnic_input_field.dart';
class SocietyScreen extends StatefulWidget {
  const SocietyScreen({Key? key}) : super(key: key);

  @override
  State<SocietyScreen> createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen> {
  String cnic = "";

void validate(){

  RegExp regexp = RegExp("^[0-9]{5}-[0-9]{7}-[0-9]");
if(regexp.hasMatch(cnic)){
  print("validate cnic");
}else{
  print("no match cnic");
}
}
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("hello")
      ),
    );
  }
}
