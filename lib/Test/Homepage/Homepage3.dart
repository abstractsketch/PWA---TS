import 'package:flutter/material.dart';

class Homepage3 extends StatelessWidget {
  const Homepage3({super.key});

  @override
  Widget build(BuildContext context) {

    const Color kPrimaryGreen = Color(0xFF608665);
    const Color kBackground = Colors.white;

    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'FREITAG, 29. AUGUST 2025',
              style: TextStyle(color: kPrimaryGreen.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            const Text(
              'Herzlich willkommen,\nMaximilian!',
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryGreen, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Serif', height: 1.1),
            ),
            const SizedBox(height: 30),
            // 1. HERO CARD
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Du siehst den Wald vor lauter Bäumen nicht?',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Atemübungen verringern Stress und helfen schneller zu entspannen.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                _buildActionCard(Icons.wb_sunny_outlined, 'Morgen-\nreflexion', 'Starte deinen Tag', kPrimaryGreen, Colors.white),
                const SizedBox(width: 16),
                _buildActionCard(Icons.nightlight_outlined, 'Abend-\nreflexion', 'Lasse den Tag Revue passieren', kPrimaryGreen, Colors.white),
              ],
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                _buildStatCard(Icons.access_time, '120', 'Minuten\nmeditiert', kPrimaryGreen),
                const SizedBox(width: 16),
                _buildStatCard(Icons.local_fire_department, '150', 'Tage\ngejournalt', kPrimaryGreen),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 70),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.add_circle, size: 32),
                  SizedBox(width: 16),
                  Text('Tagesreflexion jetzt starten', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kPrimaryGreen.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  Text(
                    '„Es ist nicht zu wenig Zeit, die wir haben, sondern es ist zu viel Zeit, die wir nicht nutzen.“',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '— Lucius Annaeus Seneca',
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('Wie fühlst du dich heute?', style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoodEmoji('😔'),
                _buildMoodEmoji('😐'),
                _buildMoodEmoji('😊'),
                _buildMoodEmoji('🤩'),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.7), size: 30),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, height: 1.1)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodEmoji(String emoji) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }

  Widget _buildActionCard(IconData icon, String title, String sub, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(),
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

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryGreen = Color(0xFF608665);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: kPrimaryGreen.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: kPrimaryGreen
              ),
            ),
            const Text("Seite im Aufbau", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}