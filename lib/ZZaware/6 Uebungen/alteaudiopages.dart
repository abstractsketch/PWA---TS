/*import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/478atem.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/meditationdank.dart';

class Audiopage2 extends StatefulWidget {
  const Audiopage2({super.key});

  @override
  State<Audiopage2> createState() => _AudioExercisesScreenState();
}

class _AudioExercisesScreenState extends State<Audiopage2> {

  static const Color primaryGreen = Color(0xFF6B8E70);
  static const Color darkGreen = Color(0xFF3A4D39);
  static const Color backgroundColor = Colors.white;
  static const Color darkTextColor = Colors.black;

  String _selectedCategory = 'Atemübungen'; // Standardmäßig wie im Bild
  String _searchQuery = "";

  final List<Map<String, String>> audioData = [
    {'title': '4 - 7 - 8 - Atmung', 'desc': 'Anfänger - Geführt', 'time': '5 min.', 'tag': 'Atemübungen'},
    {'title': '4 - 7 - 11 - Atmung', 'desc': 'Anfänger - Geführt', 'time': '5 min.', 'tag': 'Atemübungen'},
    {'title': 'Box-Breathing', 'desc': 'Anfänger - Geführt', 'time': '5-10 min.', 'tag': 'Atemübungen'},
    {'title': 'Wim-Hoff-Atmung', 'desc': 'Anfänger - Geführt', 'time': '11 min.', 'tag': 'Atemübungen'},
    {'title': 'Breath of Fire', 'desc': 'Fortgeschritten - Geführt', 'time': '9 min.', 'tag': 'Atemübungen'},
    {'title': 'Dankbarkeitsmeditation', 'desc': 'Geführt - Visualisierung', 'time': '10 min.', 'tag': 'Meditationen'},
  ];

  @override
  Widget build(BuildContext context) {

    final filteredList = audioData.where((item) {
      final matchesCategory = item['tag'] == _selectedCategory;
      final matchesSearch = item['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Audios',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Serif', color: darkTextColor),
              ),
            ),

            // Suchleiste
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black12),
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    hintText: 'Hier suchen...',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // Kategorien
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  _buildCategoryChip('Meditationen'),
                  _buildCategoryChip('Atemübungen'),
                  _buildCategoryChip('Klangkullis'),
                ],
              ),
            ),

            // Audio Liste
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  return AudioCard(
                    title: item['title']!,
                    description: item['desc']!,
                    duration: item['time']!,
                    onTap: () {
                      // INDIVIDUELLE NAVIGATION HIER
                      if (item['title'] == '4 - 7 - 8 - Atmung') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Atemeins(),
                          ),
                        );
                      } else if (item['title'] == 'Dankbarkeitsmeditation') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Meditationdank()),
                        );
                      } else{
                        // Biespielseiten für alle anderen Audios
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerDetail(title: item['title']!),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isActive = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? darkGreen : primaryGreen,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

class AudioCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final VoidCallback onTap; 

  const AudioCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B8E70),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Text(
                duration,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AudioPlayerDetail extends StatelessWidget {
  final String title;
  const AudioPlayerDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF6B8E70)),
      body: Center(child: Text("Audio Player für: $title")),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Audio/478atem.dart';
import 'package:projekt_i/Test/Audio/meditationdank.dart';

class Audiopage2 extends StatefulWidget {
  const Audiopage2({super.key});

  @override
  State<Audiopage2> createState() => _AudioExercisesScreenState();
}

class _AudioExercisesScreenState extends State<Audiopage2> {
  static const Color tealPrimary = Color(0xFF28869E);
  static const Color bgLight = Color(0xFFF0F4F6);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);

  String _searchQuery = "";
  bool _showAllBreathwork = false; 

  // DATEN MIT BILD-URLS ERWEITERT
  final List<Map<String, String>> audioData = [
    {
      'title': '4-7-8 Atmung', 
      'desc': 'Entspannung für den Schlaf', 
      'time': '5 Min', 
      'tag': 'Atemübungen',
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Lotus / Yoga
    },
    {
      'title': 'Box Breathing', 
      'desc': 'Fokus & Konzentration', 
      'time': '5 Min', 
      'tag': 'Atemübungen',
      'image': 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Natur / Fokus
    },
    {
      'title': 'Wim Hof', 
      'desc': 'Energie-Kick am Morgen', 
      'time': '11 Min', 
      'tag': 'Atemübungen',
      'image': 'https://images.unsplash.com/photo-1544367563-12123d8965cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Eis / Wasser
    },
    {
      'title': 'Breath of Fire', 
      'desc': 'Innere Hitze aktivieren', 
      'time': '9 Min', 
      'tag': 'Atemübungen',
      'image': 'https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Feuer / Sonne
    },
    {
      'title': '4-7-11 Atmung', 
      'desc': 'Tiefenentspannung', 
      'time': '7 Min', 
      'tag': 'Atemübungen',
      'image': 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Wiese
    },
    {
      'title': 'Dankbarkeit', 
      'desc': 'Visualisierung', 
      'time': '10 Min', 
      'tag': 'Meditationen',
      'image': 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' // Herz / Licht
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtern
    final breathworkList = audioData.where((item) => 
      item['tag'] == 'Atemübungen' && 
      item['title']!.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    // Anzahl Logik
    final int visibleCount = _showAllBreathwork ? breathworkList.length : (breathworkList.length > 3 ? 3 : breathworkList.length);

    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Seitenabstand leicht verringert für mehr Platz
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Übungen',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: tealPrimary),
              ),
              const SizedBox(height: 20),
              
              // Suchleiste
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    hintText: 'Suchen...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),

              const Text(
                "Breathwork",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDark),
              ),
              const SizedBox(height: 15),

              // GRID VIEW
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 Karten nebeneinander
                  crossAxisSpacing: 10, // Abstand dazwischen
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.60, // HIER ANPASSEN: Kleinerer Wert = Höhere Card (mehr Platz für Text)
                ),
                itemCount: visibleCount,
                itemBuilder: (context, index) {
                  final item = breathworkList[index];
                  return VerticalAudioCard(
                    title: item['title']!,
                    description: item['desc']!, // Jetzt mit Beschreibung
                    duration: item['time']!,
                    imageUrl: item['image']!, // Bild URL
                    onTap: () => _navigateToAudio(item['title']!),
                  );
                },
              ),

              // PFEIL BUTTON
              if (!_showAllBreathwork && breathworkList.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: IconButton(
                      onPressed: () => setState(() => _showAllBreathwork = true),
                      style: IconButton.styleFrom(backgroundColor: Colors.white),
                      icon: const Icon(Icons.keyboard_arrow_down, color: tealPrimary, size: 28),
                    ),
                  ),
                ),
               
               // Schließen Button (Optional)
               if (_showAllBreathwork && breathworkList.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: IconButton(
                      onPressed: () => setState(() => _showAllBreathwork = false),
                      icon: const Icon(Icons.keyboard_arrow_up, color: Colors.grey, size: 28),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAudio(String title) {
    if (title.contains('4-7-8')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Atemeins()));
    } else if (title.contains('Dankbarkeit')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Meditationdank()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPlayerDetail(title: title)));
    }
  }
}

// --- CARD DESIGN ---
class VerticalAudioCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String imageUrl;
  final VoidCallback onTap;

  const VerticalAudioCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BILD OBEN (Netzwerkbild oder Platzhalter)
            Expanded(
              flex: 5, // Bild nimmt ca. 50% der Höhe ein
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey.shade300, child: const Icon(Icons.image_not_supported));
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: Colors.grey.shade100);
                  },
                ),
              ),
            ),
            
            // TEXT UNTEN
            Expanded(
              flex: 5, // Textbereich
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITEL
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.bold, 
                            color: Color(0xFF1A1A1A),
                            height: 1.1
                          ),
                        ),
                        const SizedBox(height: 3),
                        // BESCHREIBUNG
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10, 
                            color: Colors.grey.shade600,
                            height: 1.1
                          ),
                        ),
                      ],
                    ),
                    // DAUER (ganz unten)
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 10, color: Colors.blueGrey),
                        const SizedBox(width: 3),
                        Text(
                          duration,
                          style: const TextStyle(fontSize: 10, color: Colors.blueGrey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioPlayerDetail extends StatelessWidget {
  final String title;
  const AudioPlayerDetail({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
*/
