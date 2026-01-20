import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/478atem.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/MeditationenPage.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/BoxBreathing.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/WImHoff.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/meditationdank.dart';
import 'package:projekt_i/main.dart'; 

class Audiopage2 extends StatefulWidget {
  const Audiopage2({super.key});

  @override
  State<Audiopage2> createState() => _AudioExercisesScreenState();
}

class _AudioExercisesScreenState extends State<Audiopage2> {
  String _selectedCategory = 'Atemübungen';
  String _searchQuery = "";

  // Controller für das horizontale Scrollen
  final ScrollController _horizontalScrollController = ScrollController();

  // Status für die Sichtbarkeit der Buttons
  bool _showLeftButton = false;
  bool _showRightButton = true;

final List<Map<String, dynamic>> breathworkdata = [
    {
      'title': 'Wim-Hoff-Atmung',
      'desc': 'Atemtechnik zur Erhöhung des Sauerstoffgehalt',
      'time': '5 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?q=80&w=800&auto=format&fit=crop' 
    },
    {
      'title': '4 - 7 - 8 - Atmung',
      'desc': '',
      'time': '∞ min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=800&auto=format&fit=crop' // Zen Steine/Ruhe
    },
    {
      'title': '4 - 7 - 11 - Atmung',
      'desc': 'Sofortige Hilfe',
      'time': '3 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1528319725582-ddc096101511?q=80&w=800&auto=format&fit=crop' // Sanfte Blätter
    },
    {
      'title': 'Box-Breathing',
      'desc': 'Waldspaziergang',
      'time': '60 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=800&auto=format&fit=crop' // Wald/Licht
    },
    {
      'title': 'Breath of Fire',
      'desc': 'Kurze Pause',
      'time': '20 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1470509037663-253ce7003996?q=80&w=800&auto=format&fit=crop' // Sonnenaufgang/Feuer-Energie
    },
    {
      'title': 'Fokus Flow',
      'desc': 'Konzentration',
      'time': '45 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?q=80&w=800&auto=format&fit=crop' // Fokus/Schreibtisch
    },
    {
      'title': 'Regengeräusche',
      'desc': 'Entspannung',
      'time': '30 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1486016006115-74a41448a0b4?q=80&w=800&auto=format&fit=crop' // Regnerische Straße / Stimmung
    },
    {
      'title': 'Body Scan',
      'desc': 'Achtsamkeit',
      'time': '15 min.',
      'tag': 'Atem',
      'targetPage': WimHoffBreathwork(),
      'image': 'https://images.unsplash.com/photo-1474418397713-7ede21d49118?q=80&w=800&auto=format&fit=crop' 
    },
  ];

  // --- Meditation Liste (neue Bilder) ---
  final List<Map<String, dynamic>> meditationdata = [
    {
      'title': 'Body Scan',
      'desc': 'Konzentration',
      'time': '5 min.',
      'tag': 'Arbeit',
      'targetPage': MeditationPage(nummer: 1, titel: 'Body Scan'),
      'image': 'https://images.unsplash.com/photo-1519834785169-98be25ec3f84?q=80&w=800&auto=format&fit=crop' // Silhouette Meditation
    },
    {
      'title': 'Grounding',
      'desc': 'Erdung nahc einem langen Tag',
      'time': '7 min.',
      'tag': 'Klang',
      'targetPage': MeditationPage(nummer: 2, titel: 'Grounding Meditation'),
      'image': 'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?q=80&w=800&auto=format&fit=crop' // Regen am Fenster / Gemütlich
    },
    {
      'title': 'Sicherheit',
      'desc': 'Ein Raum um sich in Ruhe zu entspannen',
      'time': '9 min.',
      'tag': 'Meditation',
      'targetPage': MeditationPage(nummer: 3, titel: 'Sicherheit'),
      'image': 'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?q=80&w=800&auto=format&fit=crop' // Yoga Pose / Indoor
    },
    {
      'title': 'Achtsamkeit',
      'desc': 'In dem Moment sein',
      'time': '7 min.',
      'tag': 'Atem',
      'targetPage': MeditationPage(nummer: 4, titel: 'Achtsamkeit'),
      'image': 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?q=80&w=800&auto=format&fit=crop' // Sanftes Licht / Tisch
    },
    {
      'title': 'Stille',
      'desc': 'Einfach sein',
      'time': '20 min.',
      'tag': 'Meditation',
      'targetPage': MeditationPage(nummer: 5, titel: 'Stille'),
      'image': 'https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?q=80&w=800&auto=format&fit=crop' // Tiefer Wald / Dunkelgrün
    },
  ];

// --- Klangkulissen Liste (neue Bilder) ---
  final List<Map<String, dynamic>> klangkulissendata = [
    {
      'title': 'Lebendiger Wald',
      'desc': 'Wind und Natur',
      'time': '∞',
      'tag': 'Natur',
      'targetPage': const Meditationdank(),
      'image': 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=800&auto=format&fit=crop' // Sonnenstrahlen im Wald
    },
    {
      'title': 'Regengeräusche',
      'desc': 'Beruhigender Regen',
      'time': '∞',
      'tag': 'Klang',
      'targetPage': const Meditationdank(),
      'image': 'https://images.unsplash.com/photo-1493314894560-5c412a56c17c?q=80&w=800&auto=format&fit=crop' // Dunkle, gemütliche Regentropfen
    },
    {
      'title': 'Vogelzwitschern',
      'desc': 'Frühlingserwachen',
      'time': '∞',
      'tag': 'Natur',
      'targetPage': const Meditationdank(),
      'image': 'https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=800&auto=format&fit=crop' // Vogel auf Ast / Blau-Grün
    },
    {
      'title': 'Weißes Rauschen',
      'desc': 'Fokus & Klarheit',
      'time': '∞',
      'tag': 'Fokus',
      'targetPage': const Meditationdank(),
      'image': 'https://images.unsplash.com/photo-1529651737248-dad5e287768e?q=80&w=800&auto=format&fit=crop' // Abstrakt Hell / Nebel / Luftig
    },
    {
      'title': 'Braunes Rauschen',
      'desc': 'Tiefe Entspannung',
      'time': '∞',
      'tag': 'Schlaf',
      'targetPage': const Meditationdank(),
      'image': 'https://images.unsplash.com/photo-1464695110811-dcf3903dc2f4?q=80&w=800&auto=format&fit=crop' // Dunkles Wasser / Tiefe / Erdig
    },
  ];

  @override
  void initState() {
    super.initState();
    // Listener hinzufügen, um Buttons je nach Scrollposition ein/auszublenden
    _horizontalScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _horizontalScrollController.removeListener(_scrollListener);
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // Prüft bei jeder Bewegung, ob Buttons sichtbar sein sollen
  void _scrollListener() {
    if (!_horizontalScrollController.hasClients) return;

    final offset = _horizontalScrollController.offset;
    final maxScroll = _horizontalScrollController.position.maxScrollExtent;
    
    // Toleranzbereich (Pixel), damit der Button nicht flackert
    const tolerance = 5.0;

    // Links anzeigen, wenn wir nicht mehr ganz am Anfang sind (d.h. Richtung 5. Karte gescrollt)
    final showLeft = offset > tolerance;
    
    // Rechts anzeigen, wenn wir noch nicht ganz am Ende sind
    final showRight = offset < (maxScroll - tolerance);

    if (showLeft != _showLeftButton || showRight != _showRightButton) {
      setState(() {
        _showLeftButton = showLeft;
        _showRightButton = showRight;
      });
    }
  }

  // Nach Rechts scrollen (nächste 4)
  void _scrollNext() {
    if (_horizontalScrollController.hasClients) {
      final double currentOffset = _horizontalScrollController.offset;
      final double viewportWidth = _horizontalScrollController.position.viewportDimension;
      _horizontalScrollController.animateTo(
        currentOffset + viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  // Nach Links scrollen (zurück zu den vorherigen)
  void _scrollPrev() {
    if (_horizontalScrollController.hasClients) {
      final double currentOffset = _horizontalScrollController.offset;
      final double viewportWidth = _horizontalScrollController.position.viewportDimension;
      _horizontalScrollController.animateTo(
        currentOffset - viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = breathworkdata.where((item) {
      final matchesCategory = item['tag'] == _selectedCategory;
      final matchesSearch = item['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView( 
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Übungen',
                      style: TextStyle(
                          color: AppColors.tealDark,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                    ),
                    const SizedBox(height: 20),

                    AudioSectionSlider(
                      title: "Breathwork",
                      dataList: breathworkdata,
                    ),

                    const SizedBox(height: 40), 

                    AudioSectionSlider(
                      title: "Meditationen",
                      dataList: meditationdata,
                    ),

                     const SizedBox(height: 40),

                     AudioSectionSlider(
                      title: "Klangkulissen",
                      dataList: klangkulissendata, 
                    ),
                    
                    const SizedBox(height: 50), 

                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryChip(String label) {
    bool isActive = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.tealPrimary : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(25),
          border: isActive ? null : Border.all(color: Colors.black12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.greyText,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class AudioSectionSlider extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> dataList;

  const AudioSectionSlider({
    super.key,
    required this.title,
    required this.dataList,
  });

  @override
  State<AudioSectionSlider> createState() => _AudioSectionSliderState();
}

class _AudioSectionSliderState extends State<AudioSectionSlider> {
  final ScrollController _scrollController = ScrollController();
  
  bool _showLeftButton = false;
  bool _showRightButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Initial check (falls Liste sehr kurz ist)
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final offset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    const tolerance = 5.0;

    if (maxScroll <= 0) {
      if (_showLeftButton || _showRightButton) {
        setState(() {
          _showLeftButton = false;
          _showRightButton = false;
        });
      }
      return;
    }

    final showLeft = offset > tolerance;
    final showRight = offset < (maxScroll - tolerance);

    if (showLeft != _showLeftButton || showRight != _showRightButton) {
      setState(() {
        _showLeftButton = showLeft;
        _showRightButton = showRight;
      });
    }
  }

  void _scrollNext() {
    if (_scrollController.hasClients) {
      final double currentOffset = _scrollController.offset;
      final double viewportWidth = _scrollController.position.viewportDimension;
      _scrollController.animateTo(
        currentOffset + viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _scrollPrev() {
    if (_scrollController.hasClients) {
      final double currentOffset = _scrollController.offset;
      final double viewportWidth = _scrollController.position.viewportDimension;
      _scrollController.animateTo(
        currentOffset - viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. KOPFZEILE: TITEL LINKS, BUTTONS RECHTS
        Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 10), // Right padding für Abstand zum Rand
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Schiebt Elemente auseinander
            children: [
              // TITEL
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20, // Etwas größer für bessere Hierarchie
                  fontWeight: FontWeight.bold,
                  color: AppColors.tealDark,
                ),
              ),
              
              // BUTTON GRUPPE (OBEN RECHTS)
              Row(
                children: [
                  // LINKER BUTTON
                  Visibility(
                    visible: _showLeftButton,
                    maintainSize: true, 
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: 36, // Feste, etwas kompaktere Größe für Header
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.tealPrimary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero, // Icon zentrieren
                        iconSize: 20, // Icon etwas feiner
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.tealPrimary),
                        onPressed: _scrollPrev,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 10), // Abstand zwischen den Buttons

                  // RECHTER BUTTON
                  Visibility(
                    visible: _showRightButton,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.tealPrimary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        icon: const Icon(Icons.arrow_forward_ios, color: AppColors.tealPrimary),
                        onPressed: _scrollNext,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. SLIDER BEREICH (VOLLE BREITE)
        SizedBox(
          height: 240,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Da die Buttons weg sind, haben wir mehr Platz. 
              // Berechnung leicht angepasst für vollen Screen.
              double cardWidth = constraints.maxWidth / 3.5; // Zeige ca. 3.5 Karten an
              if (cardWidth < 160) cardWidth = 160;

              return ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.dataList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = widget.dataList[index];
                  return SizedBox(
                    width: cardWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12), // Nur rechts Abstand, wirkt sauberer
                      child: AudioCard(
                        title: item['title']!,
                        description: item['desc']!,
                        duration: item['time']!,
                        imagePath: item['image']!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item['targetPage'],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// --- AUDIO CARD (REFACTORED: Keine feste Width mehr!) ---
class AudioCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String imagePath;
  final VoidCallback onTap;

  const AudioCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // WICHTIG: Hier kein Padding außenrum, das macht der Parent (ListView)
    // Auch keine feste Breite hier definieren!
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240, // Feste Höhe ist okay
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GRÜNES COVER
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // A) Das eigentliche Bild
                  Image.network(
                    imagePath, // Lädt das Bild aus den Assets
                    fit: BoxFit.cover, // Wichtig: Bild füllt den Bereich komplett
                  ),
                  
                
                ],
              ),
            ),


            // TEXT INHALT
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: AppColors.greyText),
                        ),
                      ],
                    ),
                    /*Padding(
                    padding: const EdgeInsets.only(right: 10,bottom: 250.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(Icons.play_arrow, color: AppColors.tealPrimary, size: 30),
                      ),
                    ),*/
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 10, color: AppColors.greyText),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
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
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(title)));
}









/*import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/478atem.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/meditationdank.dart';
// import 'package:projekt_i/main.dart'; // Ggf. anpassen, falls AppColors dort liegen

// --- FARBEN (Falls nicht importiert) ---
class AppColors {
  static const Color tealPrimary = Color(0xFF28869E);
  static const Color tealDark = Color(0xFF1B5E6F);
  static const Color bgLight = Color(0xFFF0F4F6);
  static const Color cardWhite = Colors.white;
  static const Color text = Colors.black;
  static const Color greyText = Color(0xFF888888);
}

class Audiopage2 extends StatefulWidget {
  const Audiopage2({super.key});

  @override
  State<Audiopage2> createState() => _AudioExercisesScreenState();
}

class _AudioExercisesScreenState extends State<Audiopage2> {
  String _selectedCategory = 'Atemübungen';
  String _searchQuery = "";

  // Controller für das horizontale Scrollen
  final ScrollController _horizontalScrollController = ScrollController();

  // Status für die Sichtbarkeit der Buttons
  bool _showLeftButton = false;
  bool _showRightButton = true;

  final List<Map<String, String>> audioData = [
    {'title': '4 - 7 - 8 - Atmung', 'desc': 'Anfänger - Geführt', 'time': '5 min.', 'tag': 'Atemübungen'},
    {'title': 'Box-Breathing', 'desc': 'Anfänger - Geführt', 'time': '5-10 min.', 'tag': 'Atemübungen'},
    {'title': 'Wim-Hoff-Atmung', 'desc': 'Anfänger - Geführt', 'time': '11 min.', 'tag': 'Atemübungen'},
    {'title': 'Dankbarkeitsmeditation', 'desc': 'Geführt - Visualisierung', 'time': '10 min.', 'tag': 'Meditationen'},
  ];

  final List<Map<String, String>> featuredData = [
    {'title': 'Morgen Routine', 'desc': 'Energie für den Tag', 'time': '10 min.', 'tag': 'Atem'},
    {'title': 'Deep Sleep', 'desc': 'Zum Einschlafen', 'time': '25 min.', 'tag': 'Klang'},
    {'title': 'Stress Relief', 'desc': 'Sofortige Hilfe', 'time': '3 min.', 'tag': 'Atem'},
    {'title': 'Nature Sounds', 'desc': 'Waldspaziergang', 'time': '60 min.', 'tag': 'Klang'},
    {'title': 'Power Nap', 'desc': 'Kurze Pause', 'time': '20 min.', 'tag': 'Schlaf'},
    {'title': 'Fokus Flow', 'desc': 'Konzentration', 'time': '45 min.', 'tag': 'Arbeit'},
    {'title': 'Regengeräusche', 'desc': 'Entspannung', 'time': '30 min.', 'tag': 'Klang'},
    {'title': 'Body Scan', 'desc': 'Achtsamkeit', 'time': '15 min.', 'tag': 'Meditation'},
  ];

  @override
  void initState() {
    super.initState();
    // Listener hinzufügen, um Buttons je nach Scrollposition ein/auszublenden
    _horizontalScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _horizontalScrollController.removeListener(_scrollListener);
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // Prüft bei jeder Bewegung, ob Buttons sichtbar sein sollen
  void _scrollListener() {
    if (!_horizontalScrollController.hasClients) return;

    final offset = _horizontalScrollController.offset;
    final maxScroll = _horizontalScrollController.position.maxScrollExtent;
    
    // Toleranzbereich (Pixel), damit der Button nicht flackert
    const tolerance = 5.0;

    // Links anzeigen, wenn wir nicht mehr ganz am Anfang sind (d.h. Richtung 5. Karte gescrollt)
    final showLeft = offset > tolerance;
    
    // Rechts anzeigen, wenn wir noch nicht ganz am Ende sind
    final showRight = offset < (maxScroll - tolerance);

    if (showLeft != _showLeftButton || showRight != _showRightButton) {
      setState(() {
        _showLeftButton = showLeft;
        _showRightButton = showRight;
      });
    }
  }

  // Nach Rechts scrollen (nächste 4)
  void _scrollNext() {
    if (_horizontalScrollController.hasClients) {
      final double currentOffset = _horizontalScrollController.offset;
      final double viewportWidth = _horizontalScrollController.position.viewportDimension;
      _horizontalScrollController.animateTo(
        currentOffset + viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  // Nach Links scrollen (zurück zu den vorherigen)
  void _scrollPrev() {
    if (_horizontalScrollController.hasClients) {
      final double currentOffset = _horizontalScrollController.offset;
      final double viewportWidth = _horizontalScrollController.position.viewportDimension;
      _horizontalScrollController.animateTo(
        currentOffset - viewportWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = audioData.where((item) {
      final matchesCategory = item['tag'] == _selectedCategory;
      final matchesSearch = item['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Übungen',
                    style: TextStyle(
                        color: AppColors.tealDark,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.1),
                  ),
                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        _buildCategoryChip('Meditationen'),
                        _buildCategoryChip('Atemübungen'),
                        _buildCategoryChip('Klangkullis'),
                      ],
                    ),
                  ),

                  // --- HORIZONTALE SEKTION ---
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Empfohlen für dich",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.tealDark),
                    ),
                  ),

                  SizedBox(
                    height: 240,
                    child: Row(
                      children: [
                        
                        // --- LINKER BUTTON ---
                        // maintainSize: true sorgt dafür, dass der Platz reserviert bleibt,
                        // auch wenn der Button unsichtbar ist. Das verhindert das Springen der Karten.
                        Visibility(
                          visible: _showLeftButton,
                          maintainSize: true, 
                          maintainAnimation: true,
                          maintainState: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.tealPrimary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.tealPrimary),
                                onPressed: _scrollPrev,
                                tooltip: "Zurück",
                              ),
                            ),
                          ),
                        ),

                        // --- LISTE (MITTE) ---
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double cardWidth = constraints.maxWidth / 4;
                              return ListView.builder(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: featuredData.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = featuredData[index];
                                  return SizedBox(
                                    width: cardWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5), // Beidseitig kleiner Abstand
                                      child: AudioCard(
                                        title: item['title']!,
                                        description: item['desc']!,
                                        duration: item['time']!,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (c) => AudioPlayerDetail(title: item['title']!)));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // --- RECHTER BUTTON ---
                        Visibility(
                          visible: _showRightButton,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.tealPrimary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.tealPrimary),
                                onPressed: _scrollNext,
                                tooltip: "Nächste anzeigen",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Alle Audios",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.tealDark),
                    ),
                  ),

                  // VERTIKALE HAUPTLISTE
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: AudioCard(
                            title: item['title']!,
                            description: item['desc']!,
                            duration: item['time']!,
                            onTap: () {
                              if (item['title'] == '4 - 7 - 8 - Atmung') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Atemeins()));
                              } else if (item['title'] == 'Dankbarkeitsmeditation') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Meditationdank()));
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPlayerDetail(title: item['title']!)));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  // _buildCategoryChip Methode hier einfügen wie zuvor...
  Widget _buildCategoryChip(String label) {
    bool isActive = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.tealPrimary : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(25),
          border: isActive ? null : Border.all(color: Colors.black12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.greyText,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
// --- AUDIO CARD (REFACTORED: Keine feste Width mehr!) ---
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
    // WICHTIG: Hier kein Padding außenrum, das macht der Parent (ListView)
    // Auch keine feste Breite hier definieren!
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240, // Feste Höhe ist okay
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GRÜNES COVER
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.tealPrimary,
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 35),
                  ),
                ),
              ),
            ),

            // TEXT INHALT
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: AppColors.greyText),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 10, color: AppColors.greyText),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
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
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(title)));
}*/