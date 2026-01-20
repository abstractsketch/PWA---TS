import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Moodchart.dart';
import 'package:projekt_i/Test/Homepage/MainLayout.dart';
import 'package:projekt_i/Test/LandingPage.dart';
import 'package:projekt_i/ZSections/Authentifikation/firebaseoptions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'dart:ui';

import 'package:projekt_i/ZSections/Layout/infopage.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/LandingPage3D.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';

import 'ZZaware/1 Login-Page/LandingPage3.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: /*DefaultFirebaseOptions.currentPlatform*/
    FirebaseOptions(
      apiKey: "AIzaSyD2LRPL7EOQM-Z-ZpAGbKw4FygByLOfUDc",
      authDomain: "projekti-6bb4c.firebaseapp.com",
      projectId: "projekti-6bb4c",
      storageBucket: "projekti-6bb4c.firebasestorage.app",
      messagingSenderId: "584129027887",
      appId: "1:584129027887:web:5bdad06a3cd3ccac8ecbda",
      measurementId: "G-V7JSKK1MZD"    
    ),
  );

  print("✅ Firebase erfolgreich initialisiert!");
  print("Projekt-ID: ${DefaultFirebaseOptions.currentPlatform.projectId}");

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    // Abrufen von Benutzerdaten
    await getUser();
    setState(() {    });
    print(uid);
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: AuthScreen(),
    );
  }
}

class AppColors {
  static const Color tealPrimary = Color(0xFF28869E); 
  static const Color tealDark = Color(0xFF1B5E6F); 
  static const Color orangeStart = Color(0xFFFF9966);
  static const Color orangeEnd = Color(0xFFFF5E62);
  static const Color bgLight = Color(0xFFF0F4F6);
  static const Color cardWhite = Colors.white;
  static const Color text = Colors.black;
  static const Color greyText = Color(0xFF888888);
}