import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projekt_i/Test/Journal/JournalEntry.dart';
import 'package:projekt_i/ZZaware/3%20Dashboard/Homepages/Slideshow.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Checkinsleep.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Gratitudeentry.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Journalentrypage.dart';
import 'package:projekt_i/Test/Journal/t%C3%A4gliche%20Frage.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart' as user;
import 'package:projekt_i/ZZaware/4%20Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/MeditationenPage.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/WImHoff.dart' hide AppColors;
import 'package:projekt_i/main.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Moodchart.dart';


class HomepageD extends StatefulWidget {
  const HomepageD({super.key});

  @override
  State<HomepageD> createState() => _HomepageDState();
}

class _HomepageDState extends State<HomepageD> {
  // Controller für die Slideshow
  final PageController _pageController = PageController();
  int _currentPage = 0;



    final List<Map<String, dynamic>> _slides = [
      {
        'gradient': [Colors.blue, Colors.purple],
        'icon': Icons.star,
        'iconColor': [Colors.orange, Colors.red],
        'title': 'Das ist Slide 1',
        'headline': 'Willkommen',
        'targetPage': const Bibliothek2(), 
      },
      {
        'gradient': [Colors.red, Colors.orange],
        'icon': Icons.favorite,
        'iconColor': [Colors.pink, Colors.purple],
        'title': 'Das ist Slide 2',
        'headline': 'Entdecke mehr',
        'targetPage': const Bibliothek2(), 
      },
    ];

    final List<Map<String, String>> _quotes = [
      {
        'text': 'Der Weg ist das Ziel.',
        'author': 'Konfuzius'
      },
      {
        'text': 'Atme tief ein. Das ist der erste Schritt zur Ruhe.',
        'author': 'Unbekannt'
      },
      {
        'text': 'Nicht was wir erleben, sondern wie wir empfinden, was wir erleben, macht unser Schicksal aus.',
        'author': 'Marie von Ebner-Eschenbach'
      },
      {
        'text': 'Gib jedem Tag die Chance, der schönste deines Lebens zu werden.',
        'author': 'Mark Twain'
      },
      {
        'text': 'Die Ruhe ist die Quelle jeder großen Kraft.',
        'author': 'Fjodor Dostojewski'
      },
      {
        'text': 'Achtsamkeit ist von Augenblick zu Augenblick gegenwärtiges, nicht urteilendes Gewahrsein.',
        'author': 'Jon Kabat-Zinn'
      },
      {
        'text': 'Die Natur eilt nicht, und doch wird alles vollbracht.',
        'author': 'Laozi'
      },
      {
        'text': 'Das Glück deines Lebens hängt von der Beschaffenheit deiner Gedanken ab.',
        'author': 'Mark Aurel'
      },
      {
        'text': 'Verweile nicht in der Vergangenheit, träume nicht von der Zukunft. Konzentriere dich auf den gegenwärtigen Moment.',
        'author': 'Buddha'
      },
      {
        'text': 'In der Mitte von Schwierigkeiten liegen die Möglichkeiten.',
        'author': 'Albert Einstein'
      },
      {
        'text': 'Lächle, atme und gehe langsam.',
        'author': 'Thich Nhat Hanh'
      },
      {
        'text': 'Auch aus Steinen, die einem in den Weg gelegt werden, kann man Schönes bauen.',
        'author': 'Johann Wolfgang von Goethe'
      },
      {
        'text': 'Wir leiden öfter in der Einbildung als in der Wirklichkeit.',
        'author': 'Seneca'
      },
      {
        'text': 'Leben allein genügt nicht, sagte der Schmetterling, Sonnenschein, Freiheit und eine kleine Blume muss man auch haben.',
        'author': 'Hans Christian Andersen'
      },
      {
        'text': 'Es gibt nur zwei Tage im Jahr, an denen man nichts tun kann. Der eine ist Gestern, der andere Morgen.',
        'author': 'Dalai Lama'
      },
      {
        'text': 'Nimm dir Zeit, um glücklich zu sein.',
        'author': 'Unbekannt'
      },
      {
        'text': 'Frieden beginnt damit, dass jeder von uns jeden Tag seinen Körper und seinen Geist pflegt.',
        'author': 'Thich Nhat Hanh'
      },
      {
        'text': 'Wer nach außen schaut, träumt. Wer nach innen schaut, erwacht.',
        'author': 'Carl Gustav Jung'
      },
      {
        'text': 'Die wahre Entdeckungsreise besteht nicht darin, neue Landschaften zu suchen, sondern mit neuen Augen zu sehen.',
        'author': 'Marcel Proust'
      },
      {
        'text': 'Stille ist nicht leer, sie ist voller Antworten.',
        'author': 'Unbekannt'
      },
      {
        'text': 'Gras wächst nicht schneller, wenn man daran zieht.',
        'author': 'Afrikanisches Sprichwort'
      },
    ];

      // Aktuelles Zitat
    late Map<String, String> currentQuote;
    
    void _randomizeQuote() {
      setState(() {
        currentQuote = _quotes[Random().nextInt(_quotes.length)];
      });
    }
    
    @override
    void initState() {
      super.initState();
      _randomizeQuote();
    }

    int _selectedMoodIndex = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    String title = _titleController.text;
    String content = _contentController.text;

    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte schreibe etwas, bevor du speicherst.")),
      );
      return;
    }

    final newEntry = {
      'date': DateTime.now().toIso8601String(),
      'mood': _selectedMoodIndex,
      'title': title,
      'content': content,
    };

    var box = Hive.box('journal');
    box.add(newEntry);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Erfolgreich im Journal gespeichert!"),
        backgroundColor: AppColors.tealPrimary,
      ),
    );

    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedMoodIndex = 0;
    });
    FocusScope.of(context).unfocus();
  }



  @override
  Widget build(BuildContext context) {
    List<String> wochentage = [
      'MONTAG', 'DIENSTAG', 'MITTWOCH', 'DONNERSTAG', 'FREITAG', 'SAMSTAG', 'SONNTAG'
    ];
    String heute = wochentage[DateTime.now().weekday - 1];
    final now = DateTime.now();
    final String dateString = "${now.day}.${now.month}.${now.year}";
    final PageController _pageController = PageController();
    int _currentPage = 0;
    Timer? _timer;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView( 
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
        
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              "$heute, $dateString",
              style: const TextStyle(
                color: AppColors.tealPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            
//so kriegt man Firebase Daten

            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
              builder: (context, snapshot) {
                String name = "Benutzer"; 

                if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  if (data != null) {
                    name = data['username'] ?? "Benutzer";
                  }
                }

                return Text(
                  'Willkommen zurück, $name',
                  style: TextStyle(
                          color: AppColors.tealDark,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                );
              },
            ),

            SizedBox(height: 25),
            const SmartSlideshow(),

            const SizedBox(height: 25),

//Stats
            Row(
              children: [
                _buildStatTile(
                  Icons.access_time_rounded, 
                  '120', 
                  'Minuten', 
                  AppColors.tealPrimary
                ),
                const SizedBox(width: 12), // Abstand etwas verringert für mehr Platz
                _buildStatTile(
                  Icons.local_fire_department_rounded, 
                  '2', 
                  'Streak',
                  AppColors.orangeStart
                ),
                const SizedBox(width: 12),
                _buildStatTile(
                  Icons.trending_up_rounded, 
                  '4', 
                  'Tage', 
                  AppColors.tealDark
                ),
              ],
            ),

            const SizedBox(height: 25),
            
//Zitate
            Container(
              width: double.infinity,
              //constraints: const BoxConstraints(maxWidth: 1200),
              height: 180, // Feste Höhe wie im Bild ca.
              decoration: BoxDecoration(
                // Die Farbe aus deinem Screenshot (Petrol/Türkis)
                color: AppColors.tealPrimary, 
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // Stack erlaubt uns, Elemente übereinander zu legen (Hintergrund-Deko, Text, Button)
              child: Stack(
                children: [
                  // 1. Dekorativer Kreis oben rechts (leicht transparent)
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // 2. Der eigentliche Text-Inhalt
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 90, 20), // Rechts viel Padding für den Button
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ZITAT DES TAGES',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // AnimatedSwitcher für einen weichen Übergang beim Textwechsel
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          child: Column(
                            // Key ist wichtig für Animation: Wenn sich der Text ändert, wird animiert
                            key: ValueKey<String>(currentQuote['text']!),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"${currentQuote['text']}"',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "- ${currentQuote['author']}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. Der Button unten rechts
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _randomizeQuote,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            // Die lachsfarbene/orange Farbe aus deinem Bild
                            color: Color(0xFFFF7E67), 
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          // Icon: Shuffle oder Refresh
                          child: const Icon(
                            Icons.cached_rounded, // Oder Icons.shuffle
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

//Reflektion         
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MindfulnessCheckIn()),
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
                          color: Colors.white.withOpacity(0.1),
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
                        Text("REFLEKTION",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        SizedBox(height: 8),
                        Text(
                          "Erstelle deinen heutigen Tagesrückblick",
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

//3 Optionen Actionkarten
            Row(
              children: [
                _buildBentoCard(
                  title: 'Dankbarkeits-\ntagebuch',
                  sub: 'Journal',
                  icon: Icons.emoji_emotions,
                  color: AppColors.cardWhite,
                  isDark: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gratitudeentry()),
                    );
                  },
                ),
                const SizedBox(width: 16),
                _buildBentoCard(
                  title: 'Abendliche\nEntspannung',
                  sub: 'Meditation',
                  icon: Icons.nightlight_outlined,
                  color: Colors.white,
                  isDark: false, 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeditationPage(nummer: 1, titel: 'Body-Scan',)),
                    );
                  },
                ),
                const SizedBox(width: 16),
                _buildBentoCard(
                  title: 'Stress-SOS',
                  sub: 'Atemübung',
                  icon: Icons.air,
                  color: AppColors.cardWhite,
                  isDark: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WimHoffBreathwork()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),



//Journal         
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => 
                      Journalentrypage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Container(
              height: 100,
              
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.tealPrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    bottom: 25,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                      ),
                      child: const Icon(Icons.book_outlined, color: Colors.white, size: 30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("JOURNAL",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        SizedBox(height: 8),
                        Text(
                          "Starte jetzt deinen täglichen Journal-Eintrag",
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

          ],
        ),
      ),
    ),
    ),
        ),
      ),  
    );
  }

  // Helper für die Bento-Karten (Journal/Event Stil)
  Widget _buildBentoCard({
  required String title,
  required String sub,
  required IconData icon,
  required Color color,
  required bool isDark,
  required VoidCallback onTap, // Neues Argument für die Verlinkung
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap, // Hier wird die Aktion ausgeführt
      borderRadius: BorderRadius.circular(25), // Damit der Ripple-Effekt abgerundet ist
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.tealDark : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: isDark ? AppColors.orangeEnd : AppColors.orangeEnd,
              size: 28,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.tealDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStatTile(IconData icon, String value, String unit, Color color) {
  return Expanded(
    child: Container(
      height: 90, // Kompakte Höhe
      padding: const EdgeInsets.all(10), // Innenabstand
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Inhalt zentrieren
        children: [
          // 1. Das Icon (Links)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1), // Leichter Hintergrund
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20), // Icon etwas kleiner
          ),
          
          const SizedBox(width: 8), // Abstand zwischen Icon und Text

          // 2. Zahl und Text (Rechts daneben, untereinander)
          Flexible( // Verhindert Fehler, wenn der Text zu lang ist
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Linksbündig zum Icon
              children: [
                // Die Zahl
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22, // Nicht zu riesig, damit es passt
                    color: Colors.black87,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                // Die Einheit
                Text(
                  unit,
                  maxLines: 1, // Einheit nur einzeilig
                  overflow: TextOverflow.ellipsis, // Pünktchen (...) wenn zu lang
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMoodEmoji(String emoji) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }
   Widget _buildMoodIcon(int index, IconData icon) {
    bool isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMoodIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.tealPrimary : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
             if(!isSelected)
             BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
             )
          ]
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.white : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildSmiley(int index, IconData icon) {
    bool isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMoodIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangeStart : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
          ],
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.white : Colors.grey.shade400,
        ),
      ),
    );
  }

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
}