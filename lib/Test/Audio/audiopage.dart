import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Audio/478atem.dart';
import 'package:projekt_i/Test/Audio/meditationdank.dart';

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