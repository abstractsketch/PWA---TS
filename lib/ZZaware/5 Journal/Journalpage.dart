import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart' as currentUser;
import 'package:projekt_i/ZZaware/5%20Journal/Dankbarkeitsentry.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Gratitudeentry.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Journalentrypage.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Kalendarpage.dart';
import 'package:projekt_i/Test/Journal/t%C3%A4gliche%20Frage.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Moodchart.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Promptslider.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/audiopage.dart' hide AppColors;
import 'package:projekt_i/ZZaware/6%20Uebungen/meditationdank.dart';
import 'package:projekt_i/main.dart';

class Journalpage2 extends StatefulWidget {
  const Journalpage2({super.key});

  @override
  State<Journalpage2> createState() => _Journalpage2State();
}

class _Journalpage2State extends State<Journalpage2> {
  int? _selectedSmileyIndex;  
  int _selectedMoodIndex = 0;

 final List<Map<String, dynamic>> myJournalData = [
    {
      'title': 'Transformiere deine Schattenseite',
      'desc': 'Entdecke dein verborgenes Ich und entfalte dein volles Potenzial.',
      'tag': 'Schattenarbeit',
      'targetPage': const Journalentrypage(), // Deine Zielseite
    },
    {
      'title': 'Frustration lösen: \nDrei Schritte',
      'desc': 'Die Ursachen von Wut und Frustration untersuchen.',
      'tag': 'Reflektion',
      'targetPage': const Journalentrypage(),
    },
    {
      'title': 'Morgendliche Dankbarkeits-Routine',
      'desc': 'Starte deinen Tag mit einer positiven Einstellung.',
      'tag': 'Achtsamkeit',
      'targetPage': const Journalentrypage(),
    },
      {
      'title': 'Abendliche Reflexion',
      'desc': 'Beende deinen Tag mit Frieden und Ruhe.',
      'tag': 'Achtsamkeit',
      'targetPage': const Journalentrypage(),
    },
    {
      'title': 'Nimm deine Schattenseiten an und stärke dein Leben',
      'desc': 'Entdecke dein verborgenes Ich und entfalte dein volles Potenzial.',
      'tag': 'Schattenarbeit',
      'targetPage': const Journalentrypage(), // Deine Zielseite
    },
    {
      'title': 'Frustration lösen: Drei Schritte',
      'desc': 'Die Ursachen von Wut und Frustration untersuchen.',
      'tag': 'Reflektion',
      'targetPage': const Journalentrypage(),
    },
    {
      'title': 'Morgendliche Dankbarkeits-Routine',
      'desc': 'Starte deinen Tag mit einer positiven Einstellung.',
      'tag': 'Achtsamkeit',
      'targetPage': const Journalentrypage(),
    },
      {
      'title': 'Abendliche Reflexion',
      'desc': 'Beende deinen Tag mit Frieden und Ruhe.',
      'tag': 'Achtsamkeit',
      'targetPage': const Journalentrypage(),
    },
  ];

  Future<void> _saveMoodToAccount(int moodIndex) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Du musst eingeloggt sein, um zu speichern.')),
      );
      return;
    }

    try {
      final now = DateTime.now();
      final dateString = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('moods') // Unterkollektion für Stimmungen
          .add({
        'mood_index': moodIndex, // 1 bis 5
        'saved_at': FieldValue.serverTimestamp(), // Genauer Server-Zeitstempel für Sortierung
        'date_string': dateString, // Einfacher String für Anzeigen/Gruppierung
      });

      _selectedMoodIndex = 0; // Auswahl zurücksetzen

      if (!mounted) return;

      // Erfolgsmeldung & Feld leeren
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erfolgreich gespeichert!'), 
          backgroundColor: AppColors.tealDark,
          duration: Duration(seconds: 2),
        ),
      );

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Speichern: $e'), backgroundColor: Colors.red),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Kleiner Helfer für das aktuelle Datum
    final now = DateTime.now();
    final String dateString = "${now.day}.${now.month}.${now.year}"; 
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView( 
        child:Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10.0, vertical: 40),
          child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Journal',
                    style: TextStyle(color: AppColors.tealDark, fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
                  ),
          
                  const SizedBox(height: 25),          
          //Journal
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Journalentrypage()));
                          },
                          child: Container(
                            height: 160,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.tealDark,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                              ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.book_sharp, color: AppColors.orangeStart, size: 28),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("JOURNAL",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                    SizedBox(height: 8),
                                    Text(
                                      "Neuen Journaleintrag\nschreiben",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      
                      // CARD RECHTS: Dankbarkeit (Dunkles Design wie im Bild rechts)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Gratitudeentry()));
                          },
                          child: Container(
                            height: 160,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.tealDark, 
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.favorite_border, color: AppColors.orangeStart, size: 28),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text("JOURNAL",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                    SizedBox(height: 8),
                                    Text(
                                      "Dankbarkeits-\ntagebuch",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  const SizedBox(height: 20),
          
          //Kalender         
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
                child: Container(
                height: 100,
                
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -35,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: AppColors.orangeStart.withOpacity(0.5),
                            shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      right: 25,
                      bottom: 20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [AppColors.tealPrimary, AppColors.tealDark]),
                        ),
                        child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 30),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("KALENDER",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          SizedBox(height: 8),
                          Text(
                            "Schaue deine alten Einträge an ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ),
          
              const SizedBox(height: 25),
          
          // DailyPrompt
                  DailyPromptWidget(),
                  
                  const SizedBox(height: 25),
          
                  JournalPromptSlider(dataList: myJournalData),
          
                  const SizedBox(height: 25),
          
          //Moodchart
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColors.tealDark, // Dunkles Teal
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.tealDark,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'CHECK-IN',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Wie fühlst du dich?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Kleines Icon oben rechts (Deko)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.tealDark,
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.waves, color: AppColors.orangeStart, size: 20),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
          
                        // Deine Smileys
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSmiley(1, Icons.sentiment_very_satisfied_outlined),
                            _buildSmiley(2, Icons.sentiment_satisfied_alt_outlined),
                            _buildSmiley(3, Icons.sentiment_neutral_outlined),
                            _buildSmiley(4, Icons.sentiment_dissatisfied_outlined),
                            _buildSmiley(5, Icons.sentiment_very_dissatisfied_outlined),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Speichern Button
                        //if (_selectedMoodIndex != 0)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              // Mache die Funktion async
                              onPressed: () {
                                // Speichern
                                _saveMoodToAccount(_selectedMoodIndex!);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orangeStart,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Speichern', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                      ],
                    ),
                  ),
          
                  const SizedBox(height: 40),
          
                  Moodchart(),
          
                  const SizedBox(height: 40),
          
                ],
              ),
            ),
          ),
                ),
        ),
      ),
    );
  }

  // Helper für Smileys (Style angepasst)
  Widget _buildSmiley(int index, IconData iconData) {
    final bool isSelected = _selectedSmileyIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSmileyIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: 32, // Etwas kleiner für Eleganz
          color: isSelected ? Colors.white : Colors.white,
        ),
      ),
    );
  }

}

/*import 'package:cloud_firestore/cloud_firestore.dart';
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
*/