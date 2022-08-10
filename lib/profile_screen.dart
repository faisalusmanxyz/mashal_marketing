import 'package:flutter/material.dart';

import 'commen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(child: const Text("Profile Screen")),
      ),
    );
  }
}
