import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Bibliothek/Artikelinfo.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/LandingPage3D.dart';
import 'package:projekt_i/ZZaware/4%20Bibliothek/ArticleDetailPage.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/MeditationDankbarkeit.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/WImHoff.dart';

class SmartSlideshow extends StatefulWidget {
  const SmartSlideshow({super.key});

  @override
  State<SmartSlideshow> createState() => _SmartSlideshowState();
}

class _SmartSlideshowState extends State<SmartSlideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Die Daten für deine 3 Folien
  // NEU: 'target' wurde hinzugefügt. Tausche LandingPage3D() gegen deine echten Seiten aus.
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'MEDITATION',
      'headline': 'Body Scan',
      'desc': 'Reise mental durch deinen Körper, um tiefsitzende Spannungen zu lösen.',
      'gradient': [Colors.blue, Colors.purple], // Lila/Blau
      'iconColor': [Colors.orange, Colors.red],
      'icon': Icons.accessibility_new_rounded,
      'target': MeditationPage(nummer: 1, titel: 'Body Scan',), // <--- HIER ZIELSEITE ÄNDERN
      '': '',
    },
    {
      'title': 'ATEMTECHNIK',
      'headline': 'Wim Hof Methode',
      'desc': 'Stärke dein Immunsystem und steigere deine Energie durch kontrolliertes Atmen.',
      'gradient': [const Color(0xFF2193b0), const Color(0xFF6dd5ed)], // Eisblau
      'iconColor': [const Color(0xFF00c6ff), const Color(0xFF0072ff)],
      'icon': Icons.air,
      'target': WimHoffBreathwork(), // <--- HIER ZIELSEITE ÄNDERN
    },
    {
      'title': 'ARTIKEL',
      'headline': 'Kraft der Dankbarkeit',
      'desc': 'Finde mehr Zufriedenheit im Alltag. Lies mehr darüber in der Bibliothek.',
      'gradient': [AppColors.orangeStart, AppColors.orangeEnd], // Warmes Orange/Gelb
      'iconColor': [const Color(0xFFEF3B36), Colors.purple],
      'icon': Icons.menu_book_rounded,
      'target': ArticleDetailPage(article: Article(title: 'Die transformative Kraft der Dankbarkeit',
      description: 'Warum das tägliche Notieren von drei Dingen dein Gehirn physisch verändern kann.',
      category: 'Dankbarkeit',
      imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60', // Hände/Sonne
      date: DateTime(2024, 6, 2),
      content: 
        'Dankbarkeit ist weit mehr als nur eine höfliche Geste oder ein kurzes "Danke". Die Neurowissenschaft zeigt, dass das aktive Praktizieren von Dankbarkeit die Struktur unseres Gehirns nachhaltig verändern kann.\n\n'
        'Wenn wir uns auf das konzentrieren, was wir haben, anstatt auf das, was uns fehlt, schüttet unser Gehirn Dopamin und Serotonin aus – die Neurotransmitter, die für Glück und Gelassenheit verantwortlich sind. Studien belegen, dass Menschen, die ein Dankbarkeitstagebuch führen, besser schlafen, weniger Stresssymptome zeigen und sogar ein stärkeres Immunsystem haben.\n\n'
        'Es geht dabei nicht darum, Probleme zu ignorieren oder eine "Good Vibes Only"-Mentalität zu erzwingen. Es geht vielmehr darum, den Fokus zu weiten. Auch an schlechten Tagen gibt es kleine Momente: Der warme Kaffee am Morgen, ein freundliches Lächeln oder einfach ein Dach über dem Kopf.\n\n'
        'Versuche diese einfache Übung: Schreibe jeden Abend drei Dinge auf, für die du heute dankbar bist. Nach 21 Tagen wirst du bemerken, dass du automatisch anfängst, den Tag über nach diesen positiven Momenten zu scannen.',
      readTime: '4 Min.',
      highlightQuote: 'Dankbarkeit ist nicht die Folge von Glück, sondern die Ursache.',)),
    },
  ];

  @override
  void initState() {
    super.initState();
    // Startet den automatischen Wechsel alle 5 Sekunden
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Wichtig: Timer stoppen, wenn Widget geschlossen wird
    _pageController.dispose();
    super.dispose();
  }

  // Manuelle Navigation Vorwärts
  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.animateToPage(_currentPage + 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  // Manuelle Navigation Rückwärts
  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(_currentPage - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      _pageController.animateToPage(_slides.length - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final slide = _slides[index];
                      // NEU: GestureDetector für die Verlinkung hinzugefügt
                      return GestureDetector(
                        onTap: () {
                          if (slide['target'] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => slide['target'],
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: slide['gradient'],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Dekorativer Kreis
                              Positioned(
                                right: -30,
                                top: -30,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              // Icon unten rechts
                              Positioned(
                                right: 25,
                                bottom: 25,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: slide['iconColor']),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                          offset: Offset(0, 4))
                                    ],
                                  ),
                                  child: Icon(slide['icon'],
                                      color: Colors.white, size: 30),
                                ),
                              ),
                              // Text Inhalt
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 90),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        slide['title'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            fontSize: 10),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      slide['headline'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      slide['desc'],
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14,
                                          height: 1.4),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Linker Pfeil
                  Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        onPressed: _prevPage,
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white70),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),

                  // Rechter Pfeil
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        onPressed: _nextPage,
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white70),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),

                  // Page Indicators (Punkte unten links)
                  Positioned(
                    bottom: 25,
                    left: 35,
                    child: Row(
                      children: List.generate(
                        _slides.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          height: 6,
                          width: _currentPage == index ? 24 : 6,
                          decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                if (_currentPage == index)
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 4)
                              ]),
                        ),
                      ),
                    ),
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