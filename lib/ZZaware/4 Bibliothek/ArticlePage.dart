import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart' hide AppColors;
import 'package:projekt_i/main.dart';



class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    const int myCurrentIndex = 2; 

    return ResponsiveWrapper(
      selectedIndex: myCurrentIndex, // Damit "Bibliothek" leuchtet
      
      onTabChange: (clickedIndex) {
        Navigator.pushReplacement(
          context,

          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => 
              ResponsiveLayout(initialIndex: clickedIndex), //gibt index weiter
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      }, 
      child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Das Header-Bild (Oben)
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1517842645767-c639042777db?q=80&w=2070&auto=format&fit=crop', 
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40), // Abstand nach Bild

                // Container für den Textinhalt (damit er nicht am Rand klebt)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // 2. Kategorie Tag & Lesezeit Zeile
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.orangeEnd,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'JOURNALPROMPTS',
                              style: GoogleFonts.carlito(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.access_time, size: 18, color: Colors.grey[500]),
                          const SizedBox(width: 6),
                          Text(
                            '3 Min.',
                            style: GoogleFonts.carlito(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 3. Überschrift (Headline)
                      Text(
                        'Journaling für Anfänger',
                        style: GoogleFonts.carlito(
                          fontSize: 42,
                          fontWeight: FontWeight.w700, // Bold
                          color: AppColors.tealDark,
                          height: 1.1,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 4. Autor Sektion
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: const NetworkImage(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
                            ),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Redaktion',
                                style: GoogleFonts.carlito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '1.6.2024',
                                style: GoogleFonts.carlito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.tealPrimary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 40),
                      
                      // Trennlinie
                      Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
                      
                      const SizedBox(height: 40),

                      // 5. Artikel Inhalt (Body)
                      Text(
                        'Wie du Journalprompts effektiv nutzt.',
                        style: GoogleFonts.carlito(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tealDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aller Anfang ist schwer. Doch Journaling muss nicht kompliziert sein. '
                        'Beginne damit, dir jeden Morgen fünf Minuten Zeit zu nehmen. '
                        'Schreibe auf, wofür du dankbar bist, oder was dich gerade beschäftigt. '
                        'Es gibt kein "Richtig" oder "Falsch" – nur deine Gedanken auf Papier.',
                        style: GoogleFonts.carlito(
                          fontSize: 18,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                      
                      // Platzhalter für mehr Content
                      const SizedBox(height: 100),
                    ],
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
}