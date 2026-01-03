import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/Login/login.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage.dart';

class landing extends StatelessWidget {
  const landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasData){
          return Homepage2();
        }else if(snapshot.hasError){
          return Center(child: Text('Etwas ist schiefgelaufen!'),);
        }else{
          return Login();
        }
      },)
    );
  }
}