import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Homepage/Test.dart';

class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {

    const Color brandGreen = Color(0xFF608665);
    const Color backgroundColor = Colors.white;
    const Color secondaryTextColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen())),
                    child: const Text(
                      'Login', 
                      style: TextStyle(color: brandGreen, fontWeight: FontWeight.w600)
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen())),
                    child: const Text('Registrieren'),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dein digitaler Begleiter für\nmentale Klarheit.',
                    style: TextStyle(
                      color: brandGreen,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nutze die PWA, um tägliche Gedanken festzuhalten, Fortschritte zu tracken und deine Ziele zu erreichen. Überall verfügbar, ganz ohne Installation.',
                    style: TextStyle(color: secondaryTextColor, fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen())),
                      child: const Text(
                        'Jetzt kostenlos starten',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildFeatureRow(
                    Icons.edit_note,
                    'Digitales Journal',
                    'Halte deine Notizen sicher und organisiert fest.',
                    brandGreen,
                  ),
                  const SizedBox(height: 30),
                  _buildFeatureRow(
                    Icons.auto_graph,
                    'Status-Tracking',
                    'Behalte deine täglichen Gewohnheiten im Blick.',
                    brandGreen,
                  ),
                  const SizedBox(height: 30),
                  _buildFeatureRow(
                    Icons.library_books,
                    'Wissens-Bibliothek',
                    'Lerne mehr über Fokus und Achtsamkeit.',
                    brandGreen,
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildFeatureRow(
                    Icons.edit_note,
                    'Lade die PWA herunter',
                    'hier beschreibung einfügen.',
                    brandGreen,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String desc, Color brandColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: brandColor, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: brandColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}