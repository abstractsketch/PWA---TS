import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart' hide AppColors;
import 'package:projekt_i/ZZaware/6%20Uebungen/WImHoff.dart';
import 'package:projekt_i/main.dart'; 

class InfoWHA extends StatelessWidget {
  const InfoWHA({super.key});

  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 2;

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
        backgroundColor: const Color(0xFFF4F6F8),
        body: SafeArea(
          child: Stack(
            children: [
              // --- SCROLLBARER INHALT ---
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- 1. DAS HEADER-BILD ---
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              image: const DecorationImage(
                                // Hier ein passendes, entspannendes Bild einfügen
                                image: NetworkImage("https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=800&q=80"),
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

                          const SizedBox(height: 32),

                          // --- 2. TAG & DAUER ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.tealPrimary, AppColors.tealDark], // Teal-Gradient für Entspannung
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "ATEMÜBUNG",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: AppColors.greyText),
                                  SizedBox(width: 4),
                                  Text(
                                    "ca. 3 - 5 Min",
                                    style: TextStyle(color: AppColors.greyText, fontSize: 13),
                                  ),
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 20),

                          // --- 3. TITEL ---
                          const Padding(
                            padding: EdgeInsets.only(left: 7.0),
                            child: Text(
                              "Die 4-7-8 Atmung",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.tealDark,
                                height: 1.2,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
                          const SizedBox(height: 30),

                          // --- 4. INFORMATIONSTEXT ---
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Was ist die 4-7-8 Technik?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.tealDark,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Diese Atemübung, entwickelt von Dr. Andrew Weil, wird auch als 'entspannender Atem' bezeichnet. Sie basiert auf alten Yoga-Techniken (Pranayama) und hilft dabei, das Nervensystem zu beruhigen. Sie ist besonders nützlich, um Stress abzubauen, Ängste zu lindern und schneller einzuschlafen.\n\n"
                              "So funktioniert es:\n"
                              "• 4 Sekunden lang ruhig durch die Nase einatmen.\n"
                              "• 7 Sekunden lang den Atem anhalten.\n"
                              "• 8 Sekunden lang hörbar durch den Mund ausatmen.",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.text,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // --- 5. SICHERHEITSHINWEISE (Wichtig!) ---
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.05), // Leichter Rotschimmer als Warnung
                              border: const Border(left: BorderSide(color: Colors.redAccent, width: 4)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                                    SizedBox(width: 8),
                                    Text(
                                      "Wichtige Sicherheitshinweise",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Bitte führe diese Übung NICHT aus (oder halte vorher Rücksprache mit einem Arzt), wenn einer der folgenden Punkte auf dich zutrifft:\n\n"
                                  "• Schwangerschaft\n"
                                  "• Asthma, COPD oder andere schwere Atemwegserkrankungen\n"
                                  "• Herz-Kreislauf-Erkrankungen oder niedriger Blutdruck\n"
                                  "• Akute Schwindelgefühle\n\n"
                                  "Solltest du dich während der Übung unwohl oder schwindelig fühlen, brich sie sofort ab und atme normal weiter.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.text,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // --- 6. START BUTTON ---
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WimHoffBreathwork()));
                                  print("Starte 4-7-8 Übung");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.orangeStart, // Oder AppColors.tealDark
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  "Jetzt Übung starten",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 50), // Platz am Ende
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // --- ZURÜCK BUTTON (Floating) ---
              Positioned(
                top: 10,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), // Leichter Hintergrund für bessere Lesbarkeit auf dem Bild
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: AppColors.tealDark, size: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}