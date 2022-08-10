import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:marshall_marketing/profile_screen.dart';
import 'package:marshall_marketing/society_screen.dart';

import 'commen.dart';
import 'form_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _curent_page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages=[SocietyScreen(),FormScreen(),ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: Colors.blue,
body: _pages[_curent_page],
bottomNavigationBar: CurvedNavigationBar(
  key: _bottomNavigationKey,
 // index: 0,
  //height: 60.0,
  items:  [
Column(
  children: const [
    Icon(Icons.home),
    Text("society"),
  ],
),Column(
      children: const [
        Icon(Icons.file_copy_outlined),
        Text("Form"),
      ],
    ),Column(
      children: const [
        Icon(Icons.person),
        Text("Profile"),
      ],
    ),

  ],
  onTap: (index){
    _curent_page=index;
    setState((){});
  },
  backgroundColor: Colors.white54,
)
    );

  }
}
