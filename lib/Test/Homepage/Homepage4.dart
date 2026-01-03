import 'package:flutter/material.dart';

class Homepage4 extends StatelessWidget {
  const Homepage4({super.key});

  @override
  Widget build(BuildContext context) {
    // Farben definieren basierend auf deinem Wunsch
    const Color kPrimaryGreen = Color(0xFF608665); // Das Haupt-Grün
    const Color kBackground = Colors.white;
    const Color kLightCard = Color(0xFFF8F9F8); // Sehr dezentes Grau/Grün für die Cards

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Zentrierter Header-Stil
            children: [
              const SizedBox(height: 20),
              // 1. DATUM & BEGRÜSSUNG
              Text(
                'FREITAG, 29. AUGUST 2025',
                style: TextStyle(color: kPrimaryGreen.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              const Text(
                'Guten Tag,\nThomas!',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryGreen, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Serif', height: 1.1),
              ),
              const SizedBox(height: 30),

              // 2. WOCHEN-KALENDER (Horizontal)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCalendarDay('Mo', '25', false, kPrimaryGreen),
                  _buildCalendarDay('Di', '26', true, kPrimaryGreen), // Aktiv
                  _buildCalendarDay('Mi', '27', false, kPrimaryGreen),
                  _buildCalendarDay('Do', '28', true, kPrimaryGreen), // Aktiv
                  _buildCalendarDay('Fr', '29', false, kPrimaryGreen),
                  _buildCalendarDay('Sa', '30', true, kPrimaryGreen), // Aktiv
                  _buildCalendarDay('So', '31', false, kPrimaryGreen),
                ],
              ),
              const SizedBox(height: 32),

              // 3. REFLEXIONS-CARDS (Zwei nebeneinander)
              Row(
                children: [
                  _buildActionCard(Icons.wb_sunny_outlined, 'Morgen-\nreflexion', 'Starte deinen Tag', kPrimaryGreen, kLightCard),
                  const SizedBox(width: 16),
                  _buildActionCard(Icons.nightlight_outlined, 'Abend-\nreflexion', 'Lasse den Tag Revue passieren', kPrimaryGreen, kLightCard),
                ],
              ),
              const SizedBox(height: 24),

              // 4. QUOTE CARD (Dunkelgrün mit "X")
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kPrimaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    const Column(
                      children: [
                        Icon(Icons.format_quote, color: Colors.white, size: 40),
                        Text(
                          '„Habe keine Angst davor, langsam zu gehen. Habe nur Angst davor, stehen zu bleiben.“',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic, height: 1.4),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '— CHINESISCHES SPRICHWORT',
                          style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(Icons.close, color: Colors.white.withOpacity(0.5), size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. MOOD TRACKER ZEILE (Wie geht es dir heute?)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kLightCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kPrimaryGreen.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny, color: kPrimaryGreen, size: 30),
                    const SizedBox(width: 16),
                    const Text('30', style: TextStyle(color: kPrimaryGreen, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Wie fühlst du dich heute Morgen?',
                        style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Platz für FAB
            ],
          ),
        ),
      ),
      
      // FLOATING ACTION BUTTON (Zentral)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryGreen,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(Icons.home, color: kPrimaryGreen), onPressed: () {}),
              IconButton(icon: const Icon(Icons.calendar_month, color: Colors.black26), onPressed: () {}),
              const SizedBox(width: 40), // Platz für den FAB
              IconButton(icon: const Icon(Icons.book, color: Colors.black26), onPressed: () {}),
              IconButton(icon: const Icon(Icons.analytics, color: Colors.black26), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  // Widget für die Kalendertage
  Widget _buildCalendarDay(String label, String day, bool isActive, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.black26, fontSize: 12)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive ? null : Border.all(color: Colors.black12),
          ),
          child: Text(
            day,
            style: TextStyle(color: isActive ? Colors.white : color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Widget für die Reflexions-Cards
  Widget _buildActionCard(IconData icon, String title, String sub, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orangeAccent, size: 30),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black38, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}