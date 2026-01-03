import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projekt_i/Test/Audio/audiopage.dart';
import 'package:projekt_i/Test/Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Journal/Kalendarpage.dart';
import 'package:projekt_i/Test/Homepage/Homepage3.dart';

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
    
    switch (_currentIndex) {
      case 0:
        content = const Homepage3();
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
    }

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

      bottomNavigationBar: BottomNavigationBar(
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
      
      // HIER wird der dynamische Inhalt geladen
      body: content, 
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