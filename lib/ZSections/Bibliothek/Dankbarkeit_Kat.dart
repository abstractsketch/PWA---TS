import 'package:flutter/material.dart';

class UebersichtSeite extends StatelessWidget {
  const UebersichtSeite({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Morgendliche Dankbarkeit',
        'duration': '5 Min',
        'type': 'Meditation',
        'level': 'Einsteiger',
        'color': Colors.pink[100],
        'page': const DankbarkeitKat(),
      },
      {
        'title': 'Reflexion am Abend',
        'duration': '7 Min',
        'type': 'Audio',
        'level': 'Fortgeschritten',
        'color': Colors.blue[100],
        'page': const DankbarkeitKat(), 
      },
      {
        'title': 'Achtsamkeit im Alltag',
        'duration': '3 Min',
        'type': 'Text',
        'level': 'Kurzimpuls',
        'color': Colors.green[100],
        'page': const DankbarkeitKat(),
      },
      {
        'title': 'Achtsamkeit im Alltag',
        'duration': '3 Min',
        'type': 'Text',
        'level': 'Kurzimpuls',
        'color': Colors.green[100],
        'page': const DankbarkeitKat(),
      },
      {
        'title': 'Achtsamkeit im Alltag',
        'duration': '3 Min',
        'type': 'Text',
        'level': 'Kurzimpuls',
        'color': Colors.green[100],
        'page': const DankbarkeitKat(),
      },
      {
        'title': 'Achtsamkeit im Alltag',
        'duration': '3 Min',
        'type': 'Text',
        'level': 'Kurzimpuls',
        'color': Colors.green[100],
        'page': const DankbarkeitKat(),
      },
      {
        'title': 'Achtsamkeit im Alltag',
        'duration': '3 Min',
        'type': 'Text',
        'level': 'Kurzimpuls',
        'color': Colors.green[100],
        'page': const DankbarkeitKat(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dankbarkeitsübungen'),
        backgroundColor: Colors.brown[200],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.brown[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wähle eine Übung aus:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hier findest du verschiedene Übungen zur Dankbarkeit, '
                  'Achtsamkeit und Selbstreflexion. Jede Einheit enthält eine kurze '
                  'Einführung, eine geführte Meditation oder eine Reflexionsaufgabe, '
                  'die dir hilft, bewusster zu leben und innere Ruhe zu finden.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Liste der Items
          ...items.map((item) {
            final title = item['title'] as String;
            final duration = item['duration'] as String;
            final type = item['type'] as String;
            final level = item['level'] as String;
            final color = item['color'] as Color?;
            final page = item['page'] as Widget;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: color ?? Colors.brown[100],
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _InfoChip(icon: Icons.access_time, label: duration),
                          const SizedBox(width: 8),
                          _InfoChip(
                              icon: Icons.play_circle_fill, label: type),
                          const SizedBox(width: 8),
                          _InfoChip(icon: Icons.star, label: level),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.brown[800]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.brown[800],
          ),
        ),
      ],
    );
  }
}

class DankbarkeitKat extends StatelessWidget {
  const DankbarkeitKat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dankbarkeit – Detailansicht')),
      body: const Center(child: Text('Inhalt der Übung')),
    );
  }
}
