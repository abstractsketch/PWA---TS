import 'package:flutter/material.dart';
import 'package:projekt_i/Login%202/auth.dart';
import 'package:projekt_i/Test/Homepage/Homepage3.dart';
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
      home: Homepage3(),

      //MindInfoPage() alten Login
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MeinWebAuftritt());
}

class MeinWebAuftritt extends StatelessWidget {
  const MeinWebAuftritt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Statische Flutter Seite',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Webseite'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(onPressed: () {}, child: const Text('Home')),
          TextButton(onPressed: () {}, child: const Text('Über uns')),
          TextButton(onPressed: () {}, child: const Text('Kontakt')),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.rocket_launch, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Willkommen auf meiner Flutter-Seite!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Dies ist ein Beispiel für eine einfache, statische Webseite, '
                  'die komplett in Dart geschrieben wurde.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // Hier könnte eine Aktion stehen
                },
                icon: const Icon(Icons.info),
                label: const Text('Mehr erfahren'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[200],
                child: const Center(child: Text('Footer Bereich © 2026')),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/