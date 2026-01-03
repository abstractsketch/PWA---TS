import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/Login%202/auth.dart' as currentUser;
import 'package:projekt_i/Test/Journal/Dankbarkeitsentry.dart';
import 'package:projekt_i/Test/Journal/Journalentrypage.dart';
import 'package:projekt_i/Test/Journal/Kalendarpage.dart';
import 'package:projekt_i/Test/Journal/t%C3%A4gliche%20Frage.dart';

class Journalpage2 extends StatefulWidget {
  const Journalpage2({super.key});

  @override
  State<Journalpage2> createState() => _Journalpage2State();
}

class _Journalpage2State extends State<Journalpage2> {
  static const Color primaryGreen = Color(0xFF6B8E70);
  static const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static const Color darkTextColor = Color(0xFF2D2D2D);

  int? _selectedSmileyIndex;

  void _saveMoodToAccount(int moodIndex) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.uid)
      .collection('daily_moods')
      .doc(today.toIso8601String())
      .set({
          'date': today,
          'moodIndex': moodIndex,
          'savedAt': FieldValue.serverTimestamp(),
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Journal',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: darkTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tägliche Selbstreflexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Wie fühlst du dich heute?',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSmiley(0, Icons.sentiment_very_satisfied_outlined),
                        _buildSmiley(1, Icons.sentiment_satisfied_alt_outlined),
                        _buildSmiley(2, Icons.sentiment_neutral_outlined),
                        _buildSmiley(3, Icons.sentiment_dissatisfied_outlined),
                        _buildSmiley(4, Icons.sentiment_very_dissatisfied_outlined),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedSmileyIndex == null 
                          ? null 
                          : () {
                              _saveMoodToAccount(_selectedSmileyIndex!);
                              
                              final DateTime now = DateTime.now();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Stimmung für den ${now.day}.${now.month}. gespeichert!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Speichern',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              _buildNavCard(
                title: 'Neuer Journaleintrag',
                description: 'Schreibe deine Gedanken nieder und mache den Kopf frei.',
                icon: Icons.edit_note,
                color: Colors.white,
                textColor: darkTextColor,
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Journalentrypage(), ),
                  );
                },
              ),
              const SizedBox(height: 15),

              _buildNavCard(
                title: 'Dankbarkeitstagebuch',
                description: 'Wofür bist du heute besonders dankbar?',
                icon: Icons.favorite_border,
                color: primaryGreen,
                textColor: Colors.white,
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dankbarkeitsentry()), 
                  );
                },
              ),
              const SizedBox(height: 20),

              const DailyPromptWidget(), 
              const SizedBox(height: 20),

              _buildNavCard(
                title: 'Rückblick & Reflektion',
                description: 'Schaue dir deine letzten Einträge an und erkenne Muster.',
                icon: Icons.history_edu,
                color: primaryGreen,
                textColor: Colors.white,
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()), 
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmiley(int index, IconData iconData) {
    final bool isSelected = _selectedSmileyIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSmileyIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.3) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: 40,
          color: isSelected ? Colors.white : Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildNavCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: color == Colors.white ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ] : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      color: textColor.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Icon(icon, size: 30, color: textColor),
          ],
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("Hier kommt die Seite: $title")),
    );
  }
}