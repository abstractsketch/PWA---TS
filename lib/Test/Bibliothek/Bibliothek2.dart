import 'package:flutter/material.dart';

class Bibliothek2 extends StatefulWidget {
  const Bibliothek2({super.key});

  @override
  State<Bibliothek2> createState() => _Bibliothek2State();
}

class _Bibliothek2State extends State<Bibliothek2> {

  final Color kPrimaryGreen = const Color(0xFF608665);
  final Color kBackground = Colors.white;

  String _selectedCategory = 'Alles';
  String _searchText = ''; // eingegebener Suchtext
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> libraryItems = [
    {
      'title': 'Die Wissenschaft dahinter: Wie Meditation dein Gehirn verändert',
      'image': 'https://unsplash.com/de/fotos/man-in-black-crew-neck-t-shirt-using-black-laptop-computer-b9-odQi5oDo',
      'category': 'Achtsamkeit',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Mythos Meditation: Warum du nicht stundenlang stillsitzen musst',
      'image': 'https://images.unsplash.com/photo-1518134346581-4f7d268d0cb0?q=80&w=800&auto=format&fit=crop',
      'category': 'Achtsamkeit',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Achtsamkeit vs. Entspannung: Wo liegt der Unterschied?',
      'image': 'https://images.unsplash.com/photo-1533227297464-942624f4699f?q=80&w=800&auto=format&fit=crop',
      'category': 'Achtsamkeit',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Der Autopilot-Modus: Wie du lernst, wieder selbst zu steuern',
      'image': 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=800&auto=format&fit=crop',
      'category': 'Fokus',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Besser schlafen: Techniken für die Nacht',
      'image': 'https://images.unsplash.com/photo-1519681393798-38e36fefce15?q=80&w=800&auto=format&fit=crop',
      'category': 'Schlaf',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Dankbarkeit im Alltag: Das Gehirn auf Positives trainieren',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=800&auto=format&fit=crop',
      'category': 'Dankbarkeit',
      'content': 'Hier kommt der Text rein.'
    },
    {
      'title': 'Fokus im Alltag: Produktiver arbeiten',
      'image': 'https://images.unsplash.com/photo-1517021897933-0e0319cfbc28?q=80&w=800&auto=format&fit=crop',
      'category': 'Fokus',
      'content': 'Hier kommt der Text rein.'
    },
  ];

  final List<String> categories = ['Alles', 'Achtsamkeit', 'Dankbarkeit', 'Schlaf', 'Fokus'];

  

  @override
  Widget build(BuildContext context) {
    // FILTER LOGIK: Kategorie UND Suchtext
    final filteredItems = libraryItems.where((item) {
      final matchCategory = _selectedCategory == 'Alles' || item['category'] == _selectedCategory;
      final matchSearch = item['title']!.toLowerCase().contains(_searchText.toLowerCase());
      
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: kBackground,
      // Damit die Tastatur das Layout nicht kaputt macht beim Öffnen
      resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    Text(
                      'Bibliothek',
                      style: TextStyle(
                        color: kPrimaryGreen,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // suchleiste
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black87, width: 1.5),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          // Suchtext aktualisieren
                          setState(() {
                            _searchText = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Suchen...',
                          hintStyle: TextStyle(color: Colors.black54),
                          prefixIcon: SizedBox(width: 15),
                          suffixIcon: Icon(Icons.search, color: Colors.black87, size: 28),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: _buildFilterChip(
                              category, 
                              _selectedCategory == category, 
                              kPrimaryGreen
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        if (_selectedCategory != 'Alles' || _searchText.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = 'Alles';
                                _searchText = '';
                                _searchController.clear();
                              });
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(color: kPrimaryGreen, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // liste
                    filteredItems.isEmpty 
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 60, color: Colors.grey[300]),
                              const SizedBox(height: 10),
                              const Text("Keine Artikel gefunden", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true, 
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0), // Abstand zwischen den Cards
                            child: _buildLibraryCard(
                              context,
                              item['title']!,
                              item['image']!,
                              kPrimaryGreen,
                              Colors.white,
                              item['category']!,
                              item['content']! // Inhalt übergeben
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: color.withOpacity(0.5)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildLibraryCard(BuildContext context, String title, String imageUrl, Color bgColor, Color textColor, String category, String content) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(
              title: title, 
              imageUrl: imageUrl, 
              category: category,
              content: content,
            ),
          ),
        );
      },
      child: Container(
        height: 140, 
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Image.network(
                imageUrl,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: textColor.withOpacity(0.7)),
                        const SizedBox(width: 4),
                        Text("5 Min", style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 10)),
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

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String category;
  final String content;

  const ArticleDetailPage({
    super.key, 
    required this.title, 
    required this.imageUrl, 
    required this.category,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryGreen = Color(0xFF608665);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: kPrimaryGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kPrimaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3D31),
                      fontFamily: 'Serif',
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Autor & Zeit
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 20, color: Colors.white),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Redaktion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text("02.01.2025 • 5 Min. Lesezeit", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                  const Divider(height: 40),
                  
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // text dann nur oben einfüge
                  const Text(
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                    style: TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}