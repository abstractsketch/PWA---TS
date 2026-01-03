import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/ZSections/Authentifikation/loginorregister.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage.dart';

class auth3 extends StatelessWidget {
  const auth3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return Homepage2();
          } else {
            return const Loginorregister();
          }
        },
      ),
    );
  }
}