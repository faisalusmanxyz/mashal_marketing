import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marshall_marketing/signIn_screen.dart';

final mashalAppBar = AppBar(
  centerTitle: true,
  title: const Text("Mashaal Marketing"),
  actions: [
    Builder(
      builder: (BuildContext context) {
        if (FirebaseAuth.instance.currentUser != null) {
          return IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()));
              },
              icon: const Icon(Icons.exit_to_app));
        }
        return const Text("");
      },
    ),
  ],
);

InputDecoration textFieldDecoration({label}) {
  return InputDecoration(
    label: Text(label),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
// Form field
