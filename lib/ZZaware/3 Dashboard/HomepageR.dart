import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/3%20Dashboard/Homepages/HomepageD.dart';

class HomepageR extends StatelessWidget {
  const HomepageR({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <550) {
          return const HomepageD(); 
        } else if (constraints.maxWidth < 1100) {
          return const HomepageD(); 
        } else {
          return const HomepageD(); 
        }
      },
    );
  }
}

// --- FARBPALETTE ---
class AppColors {
  static const Color tealPrimary = Color(0xFF28869E); 
  static const Color tealDark = Color(0xFF1B5E6F); 
  static const Color orangeStart = Color(0xFFFF9966);
  static const Color orangeEnd = Color(0xFFFF5E62);
  static const Color bgLight = Color(0xFFF0F4F6);
  static const Color cardWhite = Colors.white;
}

class HomepageS extends StatelessWidget {
  const HomepageS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // HEADER
            const Text(
              'FREITAG, 29. AUGUST 2025',
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1),
            ),
            const SizedBox(height: 4),
            const Text(
              'Herzlich willkommen,\nMaximilian!',
              style: TextStyle(color: AppColors.tealDark, fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
            ),
            const SizedBox(height: 30),

            // 1. HERO CARD (Gestylt wie dein Dashboard-Banner)
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.tealPrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30, top: -30,
                    child: Container(width: 150, height: 150, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle)),
                  ),
                  // Das Signature Orange Element (Play/Atem-Icon)
                  Positioned(
                    right: 25, bottom: 25,
                    child: Container(
                      width: 60, height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                      ),
                      child: const Icon(Icons.air, color: Colors.white, size: 30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("FOKUS FINDEN", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 8),
                        Text(
                          "Wald vor lauter\nBäumen nicht?",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. ACTION CARDS (Bento-Stil wie _buildInfoCard)
            Row(
              children: [
                _buildBentoCard(
                  title: 'Morgen-\nreflexion',
                  sub: 'Starten',
                  icon: Icons.wb_sunny_outlined,
                  color: AppColors.tealDark,
                  isDark: false,
                ),
                const SizedBox(width: 16),
                _buildBentoCard(
                  title: 'Abend-\nreflexion',
                  sub: 'Review',
                  icon: Icons.nightlight_outlined,
                  color: Colors.white,
                  isDark: true, // Dunkle Karte wie im Dashboard
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. STAT CARDS
            Row(
              children: [
                _buildStatTile(Icons.access_time, '120', 'Minuten', AppColors.tealPrimary),
                const SizedBox(width: 16),
                _buildStatTile(Icons.local_fire_department, '150', 'Tage', AppColors.orangeStart),
              ],
            ),
            const SizedBox(height: 24),

            // 4. MAIN CTA BUTTON (Gradient wie deine "Übung"-Karte)
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text('Tagesreflexion starten', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 5. QUOTE (Schlichtes Dashboard-Design)
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: const Column(
                children: [
                  Text(
                    '„Es ist nicht zu wenig Zeit, die wir haben, sondern es ist zu viel Zeit, die wir nicht nutzen.“',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.tealDark, fontSize: 15, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                  SizedBox(height: 10),
                  Text('— SENECA', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // MOOD SECTION
            const Text('Wie fühlst du dich heute?', style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['😔', '😐', '😊', '🤩'].map((e) => _buildMoodEmoji(e)).toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper für die Bento-Karten (Journal/Event Stil)
  Widget _buildBentoCard({required String title, required String sub, required IconData icon, required Color color, required bool isDark}) {
    return Expanded(
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.tealDark : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [if(!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: isDark ? AppColors.orangeStart : AppColors.tealPrimary, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isDark ? Colors.white : AppColors.tealDark, fontWeight: FontWeight.bold, fontSize: 16, height: 1.2)),
                const SizedBox(height: 4),
                Text(sub, style: TextStyle(color: isDark ? Colors.white70 : Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kleiner Info-Tile für Stats
  Widget _buildStatTile(IconData icon, String value, String unit, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.tealDark)),
                Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoodEmoji(String emoji) {
    return Container(
      width: 65, height: 65,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(String s, {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryGreen = Color(0xFF608665);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: kPrimaryGreen.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: kPrimaryGreen
              ),
            ),
            const Text("Seite im Aufbau", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// TABLET 

class HomepageT extends StatelessWidget {
  const HomepageT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // HEADER
            const Text(
              'FREITAG, 29. AUGUST 2025',
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1),
            ),
            const SizedBox(height: 4),
            const Text(
              'Herzlich willkommen,\nMaximilian!',
              style: TextStyle(color: AppColors.tealDark, fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
            ),
            const SizedBox(height: 30),

            // 1. HERO CARD (Gestylt wie dein Dashboard-Banner)
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.tealPrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30, top: -30,
                    child: Container(width: 150, height: 150, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle)),
                  ),
                  // Das Signature Orange Element (Play/Atem-Icon)
                  Positioned(
                    right: 25, bottom: 25,
                    child: Container(
                      width: 60, height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                      ),
                      child: const Icon(Icons.air, color: Colors.white, size: 30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("FOKUS FINDEN", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 8),
                        Text(
                          "Wald vor lauter\nBäumen nicht?",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. ACTION CARDS (Bento-Stil wie _buildInfoCard)
            Row(
              children: [
                _buildBentoCard(
                  title: 'Morgen-\nreflexion',
                  sub: 'Starten',
                  icon: Icons.wb_sunny_outlined,
                  color: AppColors.tealDark,
                  isDark: false,
                ),
                const SizedBox(width: 16),
                _buildBentoCard(
                  title: 'Abend-\nreflexion',
                  sub: 'Review',
                  icon: Icons.nightlight_outlined,
                  color: Colors.white,
                  isDark: true, // Dunkle Karte wie im Dashboard
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. STAT CARDS
            Row(
              children: [
                _buildStatTile(Icons.access_time, '120', 'Minuten', AppColors.tealPrimary),
                const SizedBox(width: 16),
                _buildStatTile(Icons.local_fire_department, '150', 'Tage', AppColors.orangeStart),
              ],
            ),
            const SizedBox(height: 24),

            // 4. MAIN CTA BUTTON (Gradient wie deine "Übung"-Karte)
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text('Tagesreflexion starten', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 5. QUOTE (Schlichtes Dashboard-Design)
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: const Column(
                children: [
                  Text(
                    '„Es ist nicht zu wenig Zeit, die wir haben, sondern es ist zu viel Zeit, die wir nicht nutzen.“',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.tealDark, fontSize: 15, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                  SizedBox(height: 10),
                  Text('— SENECA', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // MOOD SECTION
            const Text('Wie fühlst du dich heute?', style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['😔', '😐', '😊', '🤩'].map((e) => _buildMoodEmoji(e)).toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper für die Bento-Karten (Journal/Event Stil)
  Widget _buildBentoCard({required String title, required String sub, required IconData icon, required Color color, required bool isDark}) {
    return Expanded(
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.tealDark : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [if(!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: isDark ? AppColors.orangeStart : AppColors.tealPrimary, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isDark ? Colors.white : AppColors.tealDark, fontWeight: FontWeight.bold, fontSize: 16, height: 1.2)),
                const SizedBox(height: 4),
                Text(sub, style: TextStyle(color: isDark ? Colors.white70 : Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kleiner Info-Tile für Stats
  Widget _buildStatTile(IconData icon, String value, String unit, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.tealDark)),
                Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoodEmoji(String emoji) {
    return Container(
      width: 65, height: 65,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }

}

// --- HELPER WIDGETS ---

class ContentBox extends StatelessWidget {
  final double height;
  final Widget child;

  const ContentBox({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25), // Runde Ecken wie im Design
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Sehr subtiler Schatten
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
