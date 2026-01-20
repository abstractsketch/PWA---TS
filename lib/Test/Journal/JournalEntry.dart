import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart'; // Optional für das Datum, falls nicht vorhanden, nutze ich String
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
// Deine Imports (Pfade müssen in deinem Projekt stimmen)
import 'package:projekt_i/ZZaware/6%20Uebungen/audiopage.dart';
import 'package:projekt_i/ZZaware/4%20Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/ZZaware/5%20Journal/Kalendarpage.dart';
import 'package:projekt_i/ZZaware/3%20Dashboard/HomepageR.dart';

class JournalEntry extends StatefulWidget {
  const JournalEntry({super.key});

  @override
  State<JournalEntry> createState() => JournalEntryState();
}

class JournalEntryState extends State<JournalEntry> {
  // --- LOGIK (Unverändert) ---
  int _currentIndex = 1;
  int _selectedMoodIndex = -1;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // --- NEUE FARBPALETTE (Basierend auf Bild 2) ---
  static const Color bgLight = Color(0xFFF0F4F6); // Hellgrau/Blau Hintergrund
  static const Color tealPrimary = Color(0xFF28869E); // Das schöne Teal
  static const Color tealDark = Color(0xFF1B5E6F); // Dunkleres Teal
  static const Color orangeAccent = Color(0xFFFF7E6B); // Der Lachs/Orange Button
  static const Color orangeGradientEnd = Color(0xFFFF5E62);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);

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
        backgroundColor: tealPrimary,
      ),
    );

    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedMoodIndex = -1;
    });
    FocusScope.of(context).unfocus();
  }

  // --- UI BUILD ---

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String dateString = "${now.day}. ${now.month}. ${now.year}"; 
    const int myCurrentIndex = 1; 

    return ResponsiveWrapper(
      selectedIndex: myCurrentIndex,
      onTabChange: (clickedIndex) {
        if (clickedIndex == myCurrentIndex) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => ResponsiveLayout(initialIndex: clickedIndex),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Scaffold(
      backgroundColor: bgLight, // Neue Hintergrundfarbe
      
      // Optional: FAB entfernt, da wir jetzt den großen Button unten haben (wie im Design)
      // Falls du den Kalender-Button zwingend brauchst, kann er hier bleiben:
      floatingActionButton: _currentIndex == 1 ? FloatingActionButton(
        backgroundColor: tealDark,
        child: const Icon(Icons.history, color: Colors.white),
        onPressed: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => CalendarPage()),
           );
        },
      ) : null,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER (Datum & Begrüßung)
              Text(
                "HEUTE, $dateString", // Dynamisches Datum
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Dein tägliches Journal,",
                style: TextStyle(
                  color: tealDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // 2. TEAL CARD ("Fokus Finden" Style)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [tealPrimary, tealDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: tealPrimary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "GEDANKEN FESTHALTEN",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Was bewegt dich heute?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 3. EINGABEFELDER (Im Style der weißen Karten)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     // Titel Input
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textDark),
                      decoration: const InputDecoration(
                        hintText: "Titel deines Eintrags...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.title, color: tealPrimary),
                      ),
                    ),
                    const Divider(height: 30),
                    // Content Input
                    TextField(
                      controller: _contentController,
                      maxLines: 6,
                      style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                      decoration: const InputDecoration(
                        hintText: "Schreibe hier deine Gedanken nieder...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 4. STIMMUNG (Unten platziert wie im Bildtext "Wie fühlst du dich heute?")
              const Text(
                "Wie fühlst du dich heute?",
                style: TextStyle(
                  color: tealDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMoodIcon(0, Icons.sentiment_very_satisfied),
                  _buildMoodIcon(1, Icons.sentiment_satisfied),
                  _buildMoodIcon(2, Icons.sentiment_neutral),
                  _buildMoodIcon(3, Icons.sentiment_dissatisfied),
                  _buildMoodIcon(4, Icons.sentiment_very_dissatisfied),
                ],
              ),

              const SizedBox(height: 30),

              // 5. BUTTON (Großer roter Button wie im Bild)
              InkWell(
                onTap: _saveEntry,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [orangeAccent, orangeGradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: orangeAccent.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_circle_outline, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        "Eintrag speichern",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40), // Bottom Padding
            ],
          ),
        ),
      ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

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
          color: isSelected ? tealPrimary : Colors.white,
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
}



/*import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projekt_i/Test/Audio/audiopage.dart';
import 'package:projekt_i/Test/Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Journal/Kalendarpage.dart';
import 'package:projekt_i/Test/Homepage/HomepageR.dart';

class JournalEntry extends StatefulWidget {
  const JournalEntry({super.key});

  @override
  State<JournalEntry> createState() => JournalEntryState();
}

class JournalEntryState extends State<JournalEntry> {
  // Wir starten bei Index 1, da wir uns im "Journal" befinden
  int _currentIndex = 1;

  // Farben
  static const Color bgCream = Color(0xFFFDFDF5);
  static const Color cardGreen = Color(0xFF5A7A60);
  static const Color textDark = Color(0xFF2D2D2D);

  // Zustand für die Stimmung
  int _selectedMoodIndex = -1;

  // Controller
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
        backgroundColor: cardGreen,
      ),
    );

    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedMoodIndex = -1;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    
    /*switch (_currentIndex) {
      case 0:
        content = const HomepageR();
        break;
      case 1:
        // Das ist die Journal-Ansicht (Lokal in dieser Datei)
        content = _buildJournalView(); 
        break;
      case 2:
        content = const Bibliothek2();
        break;
      case 3:
        content = Audiopage2();
        break;
      case 4:
        content =  CalendarPage(); 
        break;
      default:
        content = _buildJournalView();
    }*/

    return Scaffold(
      backgroundColor: bgCream,
      
      floatingActionButton: _currentIndex == 1 ? FloatingActionButton(
        backgroundColor: cardGreen,
        child: const Icon(Icons.history, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarPage()),
          );
        },
      ) : null, 

      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor:  Colors.green, 
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology_outlined, size: 30), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined, size: 30), label: 'Bib'),
          BottomNavigationBarItem(icon: Icon(Icons.accessibility_new_outlined, size: 30), label: 'Audio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, size: 30), label: 'Einstellungen'),
        ],
      ),
      
      body: content, */
    );
  }

  Widget _buildJournalView() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Journal",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: textDark,
              ),
            ),
            const SizedBox(height: 20),

            // Grüne Karte
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardGreen,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const Text(
                    "Tagesselbstreflektion",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Wie fühlst du dich heute?",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMoodIcon(0, Icons.sentiment_very_satisfied),
                      _buildMoodIcon(1, Icons.sentiment_satisfied),
                      _buildMoodIcon(2, Icons.sentiment_neutral),
                      _buildMoodIcon(3, Icons.sentiment_dissatisfied),
                      _buildMoodIcon(4, Icons.sentiment_very_dissatisfied),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Titel: ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Arbeitsausfall...",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    "Gedanken zum Tag:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _contentController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: "Schreibe hier deine Gedanken auf...",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFFAFAFA),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _saveEntry,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: cardGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 40,
          color: isSelected ? cardGreen : Colors.white, 
        ),
      ),
    );
  }
}

*/