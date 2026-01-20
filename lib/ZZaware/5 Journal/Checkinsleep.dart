import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart'; 
import 'package:projekt_i/main.dart';

class MindfulnessCheckIn extends StatefulWidget {
  const MindfulnessCheckIn({super.key});

  @override
  State<MindfulnessCheckIn> createState() => _MindfulnessCheckInState();
}

class _MindfulnessCheckInState extends State<MindfulnessCheckIn> {
  // Wir speichern die Werte in einer Map, um sie einfach an Firebase zu senden
  final Map<String, int> _ratings = {
    'sleep': 0,
    'mood': 0,
    'nutrition': 0,
    'water': 0,
    'movement': 0,
    'selfcare': 0,
    'social': 0,
    'stress': 0,
  };

  bool _isUploading = false;

  // Konfiguration der Fragen und Icons
  final List<Map<String, dynamic>> _items = [
    {
      'key': 'sleep',
      'label': 'Hast du gut und genug geschlafen?',
      'icon': Icons.bedtime_outlined
    },
    {
      'key': 'mood',
      'label': 'Wie geht es dir?',
      'icon': Icons.sentiment_satisfied_alt
    },
    {
      'key': 'nutrition',
      'label': 'Wie gesund hast du dich ernährt?',
      'icon': Icons.restaurant_menu // Oder Icons.eco für Karotte
    },
    {
      'key': 'water',
      'label': 'Hast du genug Wasser getrunken?',
      'icon': Icons.local_drink_outlined
    },
    {
      'key': 'movement',
      'label': 'Hast du dich genug bewegt?',
      'icon': Icons.directions_run
    },
    {
      'key': 'selfcare',
      'label': 'Hast du etwas Schönes für dich gemacht?',
      'icon': Icons.spa_outlined
    },
    {
      'key': 'social',
      'label': 'Hast du deine sozialen Kontakte gepflegt?',
      'icon': Icons.people_outline
    },
    {
      'key': 'stress',
      'label': 'Wie hoch ist dein Stresslevel?',
      'icon': Icons.monitor_heart_outlined
    },
  ];

  // --- FIREBASE SPEICHERN ---
  Future<void> _saveToFirebase() async {
    // Einfache Validierung: Wurde alles ausgefüllt? (Optional)
    if (_ratings.containsValue(0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte bewerte alle Punkte.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Speichern in der Collection 'daily_checkins'
      await FirebaseFirestore.instance.collection('daily_checkins').add({
        'date': Timestamp.now(),
        // 'userId': FirebaseAuth.instance.currentUser?.uid, // Falls du Auth nutzt
        'ratings': _ratings,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Check-in erfolgreich gespeichert!'),
            backgroundColor: AppColors.tealPrimary,
          ),
        );
        // Optional: Zurück zur Home-Seite navigieren
        Navigator.pop(context); 
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Speichern: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 1; 

    
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
      child:Scaffold(
      backgroundColor: Colors.white, // Oder dein Background-Color
      appBar: AppBar(
        title: const Text(
          'Tages-Reflektion',
          style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor:  AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.tealDark),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              children: [
                // Untertitel
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Bewerte folgende Faktoren auf einer Skala von 1 bis 5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
            
                // Scrollbare Liste der Fragen
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
                    itemCount: _items.length,
                    separatorBuilder: (c, i) => const SizedBox(height: 30),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _buildRatingItem(
                        item['key'],
                        item['label'],
                        item['icon'],
                      );
                    },
                  ),
                ),
                Container(
                  width: 300,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.orangeStart, AppColors.orangeEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.orangeStart.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _isUploading ? null : _saveToFirebase,
            style: ElevatedButton.styleFrom(
              
              elevation: 0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: _isUploading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'SPEICHERN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
        ),
      
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      
),
      
    );
  }

  // Baut eine einzelne Frage-Kachel (Icon -> Balken -> Text)
  Widget _buildRatingItem(String key, String label, IconData icon) {
    int currentScore = _ratings[key] ?? 0;

    return Column(
      children: [
        // 1. Icon
        Icon(icon, color: AppColors.tealDark, size: 28),
        
        const SizedBox(height: 12),

        // 2. Der Bewertungsbalken (Die "Ampel")
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.orangeStart.withOpacity(0.5), width: 1.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: List.generate(5, (index) {
              int starValue = index + 1;
              bool isSelected = currentScore >= starValue;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _ratings[key] = starValue;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // Abrunden der Ecken links für das erste und rechts für das letzte Element
                      borderRadius: BorderRadius.horizontal(
                        left: index == 0 ? const Radius.circular(22) : Radius.zero,
                        right: index == 4 ? const Radius.circular(22) : Radius.zero,
                      ),
                      // Füllfarbe
                      color: isSelected 
                          ? AppColors.orangeStart.withOpacity(0.2 + (index * 0.15)) 
                          // ^^ Optional: Je höher die Zahl, desto intensiver die Farbe?
                          // Oder einfach flat: AppColors.orangeStart
                          : Colors.transparent,
                    ),
                    // Vertikale Trennlinien (nur zwischen den Elementen)
                    child: Container(
                      decoration: BoxDecoration(
                         border: index < 4 
                            ? Border(right: BorderSide(color: AppColors.orangeStart.withOpacity(0.3), width: 1)) 
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 12),

        // 3. Frage-Text
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}