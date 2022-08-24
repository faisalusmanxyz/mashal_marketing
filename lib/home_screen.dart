import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marshall_marketing/profile_screen.dart';
import 'package:marshall_marketing/society_screen.dart';

import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    const SocietyScreen(),
    const FormScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Mashaal  Marketing"),

        ),
        backgroundColor: Colors.blue,
        body: _pages[_currentPage],
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          // index: 0,
          //height: 60.0,

          items: [
            Column(
              children: const [
                Icon(Icons.home),
                Text("society"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.file_copy_outlined),
                Text("Form"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.person),
                Text("Profile"),
              ],
            ),
          ],
          onTap: (index) async {
            _currentPage = index;
            // print(FirebaseAuth.instance.currentUser?.email);
            // if ((index == 1 && FirebaseAuth.instance.currentUser == null)) {
            //   await Navigator.pushNamed(context, 'login');
            //
            //   _currentPage = 0;
            // }
            setState(() {});
          },
          backgroundColor: Colors.white54,
        ));
  }
}
