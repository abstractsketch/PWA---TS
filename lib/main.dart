import 'package:flutter/material.dart';
import 'package:projekt_i/Login%202/auth.dart';
import 'package:projekt_i/Test/LandingPage.dart';
import 'package:projekt_i/ZSections/Authentifikation/firebaseoptions.dart';
import 'package:firebase_core/firebase_core.dart';

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
      theme: ThemeData(fontFamily: 'Carlito'),
      home: LandingPage2(),

      //MindInfoPage() alten Login
    );
  }
}