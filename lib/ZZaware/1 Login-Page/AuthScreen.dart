import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/Userscreen.dart' hide AppColors;
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/MeditationenPage.dart';
import 'dart:ui';
import '../../ZSections/Authentifikation/google_sign_in_button.dart';
import 'package:projekt_i/main.dart';


class AuthScreen extends StatefulWidget {
  @override

  const AuthScreen({super.key});

  State<AuthScreen> createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;
  late AnimationController _animController;
  final List<FloatingBall> _balls = [];
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
    
    // 1. Animation initialisieren (Source B)
    _animController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 1)
    )..repeat();

    for (int i = 0; i < 7; i++) {
      _balls.add(FloatingBall(
        radius: _rng.nextDouble() * 50 + 30,
        x: _rng.nextDouble(), 
        y: _rng.nextDouble(),
        dx: (_rng.nextDouble() - 0.5) * 0.0005, 
        dy: (_rng.nextDouble() - 0.5) * 0.0005,
      ));
    }
  }


  // --- LOGIK (Unverändert) ---
  Future<void> _submitAuth() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ResponsiveLayout()));
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserInfoScreen()));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
    }
  }
  // ---------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealPrimary, 
      body: Stack(
        children: [
          
          // 1. ANIMIERTE BÄLLE MIT VERLAUF (Source B UI)
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return CustomPaint(
                painter: BallPainter(_balls),
                child: Container(),
              );
            },
          ),

          // 2. BLUR EFFEKT (Source B UI)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: AppColors.tealDark.withOpacity(0.2), 
            ),
          ),

       Stack(
        children: [

          // 2. INHALT (Zentriert)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / Titel
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.orangeStart, AppColors.orangeEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "aware.",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isLogin ? "Schön, dass du wieder da bist." : "Starte deine Reise zu mehr Ruhe.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Begrenzte Breite für das Formular (Maximal 360px)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Column(
                      children: [
                        _buildCompactTextField(_emailController, "Email", false),
                        const SizedBox(height: 16),
                        _buildCompactTextField(_passwordController, "Passwort", true),
                        
                        const SizedBox(height: 30),

                        // Login Button
                        Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            // Hier definierst du den Gradienten
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.orangeStart,
                                AppColors.orangeEnd,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10), 
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 4),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, 
                              shadowColor: Colors.transparent,     
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _submitAuth,
                            child: Text(
                              isLogin ? "Einloggen" : "Registrieren",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        
                        // Google Button
                        SizedBox(
                          height: 45,
                          child: GoogleButton() // Nimmt die Höhe des Parents an wenn möglich
                        ),

                        const SizedBox(height: 30),

                        // Umschalter
                        GestureDetector(
                          onTap: () => setState(() => isLogin = !isLogin),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: Colors.transparent, // Erweitert Klickbereich
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLogin ? "Kein Konto? " : "Bereits dabei? ",
                                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 13),
                                ),
                                Text(
                                  isLogin ? "Registrieren" : "Anmelden",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
        ],
      ),
      
    );
  }

  Widget _buildCompactTextField(TextEditingController controller, String hint, bool obscure) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 14), 
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          border: InputBorder.none,
          isDense: true, // WICHTIG: Macht das Feld kompakter
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
          suffixIcon: obscure 
            ? const Icon(Icons.lock_outline_rounded, size: 18, color: Colors.grey)
            : const Icon(Icons.email_outlined, size: 18, color: Colors.grey),
        ),
      ),
    );
  }
  
  // Kleiner Helfer für Web-Kompatibilität bei Blur
  ImageFilter kIsWebFilter() {
      // Vereinfacht: Normalerweise müsste man hier platform checken. 
      // ImageFilter.blur funktioniert aber standardmäßig in Flutter.
      return ImageFilter.blur(sigmaX: 60, sigmaY: 60); 
  }
}
