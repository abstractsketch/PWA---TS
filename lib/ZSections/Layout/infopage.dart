import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Layout/drawers.dart';

class MindInfoPage extends StatelessWidget {
  const MindInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mind"),
        elevation: 0,
      ),

      drawer: const Drawers(),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bilder/berge.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              /*child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.6)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Finde Ruhe im Moment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),*/
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Willkommen bei Mind",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Mind unterstützt dich mit Meditationen, Atemübungen, "
                    "Soundscapes und Tools für mehr Achtsamkeit. "
                    "Eine App zum Entspannen, Fokussieren und Verstehen.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _sectionTitle("Funktionen"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _featureCard(
                    icon: Icons.spa,
                    title: "Meditationen",
                    description: "Geführte Sessions für Fokus, Schlaf und Ruhe.",
                  ),
                  _featureCard(
                    icon: Icons.air,
                    title: "Atemübungen",
                    description:
                        "Beruhigende und aktivierende Breathwork-Übungen.",
                  ),
                  _featureCard(
                    icon: Icons.favorite_border,
                    title: "Dankbarkeitstagebuch",
                    description:
                        "Reflektiere täglich, um positive Gedanken zu stärken.",
                  ),
                  _featureCard(
                    icon: Icons.headphones,
                    title: "Soundscapes",
                    description:
                        "Sanfte Natur- und Ambient-Klänge für Wohlbefinden.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [

          // Text-Bereich
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 32, color: Colors.blueGrey),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

