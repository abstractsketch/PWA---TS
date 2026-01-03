import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Notizen/Reflektion.dart';

class Notizen extends StatefulWidget {
  const Notizen({super.key});

  @override
  State<Notizen> createState() => _NotizenState();
}

class _NotizenState extends State<Notizen> {
  final Map<String, int> _ratings = {
    'Schlaf': 0,
    'Stresslevel': 0,
    'Ernährung': 0,
    'Stimmung': 0,
  };

  void _updateRating(String key, int value) {
    setState(() {
      _ratings[key] = value;
    });
  }

  Widget _buildRatingRow(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 10),

        /// Rating Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final isSelected = _ratings[title] == index + 1;
            return GestureDetector(
              onTap: () => _updateRating(title, index + 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 38,
                width: 50,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey[300] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notizen")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// === Selbsteinschätzung (JETZT mit PrettyCard) ===
          PrettyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tägliche Selbsteinschätzung',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 16),
                _buildRatingRow('Schlaf'),
                _buildRatingRow('Stresslevel'),
                _buildRatingRow('Ernährung'),
                _buildRatingRow('Stimmung'),
              ],
            ),
          ),

          /// === Reflektion (auch in PrettyCard) ===
          PrettyCard(
            child: Reflektion(), // Widget bleibt identisch, nur design neu
          ),
        ],
      ),
    );
  }
}

class PrettyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PrettyCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }
}
