import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:projekt_i/main.dart'; // Zugriff auf AppColors

class Moodchart extends StatefulWidget {
  const Moodchart({super.key});

  @override
  State<Moodchart> createState() => _MoodchartState();
}

class _MoodchartState extends State<Moodchart> {
  // Index 0 = Vor 6 Tagen, Index 6 = Heute
  List<double> _weeklyValues = List.filled(7, 0.0);
  List<String> _weekDays = List.filled(7, ''); // Platzhalter
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMoodData();
  }

  Future<void> _fetchMoodData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final now = DateTime.now();
    final startOfPeriod = now.subtract(const Duration(days: 6));
    // Uhrzeit auf 00:00:00 setzen
    final startFilter = DateTime(startOfPeriod.year, startOfPeriod.month, startOfPeriod.day);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('moods')
          .where('saved_at', isGreaterThanOrEqualTo: startFilter)
          .get();

      Map<String, List<int>> groupedMoods = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final timestamp = (data['saved_at'] as Timestamp).toDate();
        final moodIndex = data['mood_index'] as int;
        
        final dateKey = DateFormat('dd.MM').format(timestamp);

        if (!groupedMoods.containsKey(dateKey)) {
          groupedMoods[dateKey] = [];
        }
        groupedMoods[dateKey]!.add(moodIndex);
      }

      List<double> tempValues = [];
      List<String> tempDays = [];

      for (int i = 6; i >= 0; i--) {
        final day = now.subtract(Duration(days: i));
        final dateKey = DateFormat('dd.MM').format(day);
        
        // HIER DIE ÄNDERUNG: Datum formatieren (z.B. 16.01)
        String dayLabel = DateFormat('dd.MM').format(day); 

        tempDays.add(dayLabel);

        if (groupedMoods.containsKey(dateKey)) {
          final moods = groupedMoods[dateKey]!;
          double avg = moods.reduce((a, b) => a + b) / moods.length;
          tempValues.add(avg);
        } else {
          tempValues.add(0.0);
        }
      }

      if (mounted) {
        setState(() {
          _weeklyValues = tempValues;
          _weekDays = tempDays;
          _isLoading = false;
        });
      }

    } catch (e) {
      print("Fehler beim Laden der Moods: $e");
      if (mounted) setState(() => _isLoading = false);
    }
    
  }

  

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: double.infinity,
      height: 300, // Etwas höher für die Datumsanzeige
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.tealDark, // Dunkler Hintergrund wie beim Check-In
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.tealDark.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Analog zum Check-In Widget)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ÜBERSICHT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Deine Woche",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Kleines Deko Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 20),
              )
            ],
          ),
          
          const SizedBox(height: 30), // Abstand zum Chart
          
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 5,
                minY: 0,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  
                  // Linke Achse (Zahlen 1-5)
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const SizedBox.shrink();
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.white38, // Dunkleres Weiß für Achse
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Untere Achse (Datum: 16.01)
                  // ... innerhalb von FlTitlesData( ...

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40, // Genug Platz reservieren!
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        
                        // 1. Sicherheits-Check: Index gültig?
                        if (index >= 0 && index < _weekDays.length) {
                          
                          // 2. Sicherheits-Check: Ist Text da?
                          if (_weekDays[index].isEmpty) {
                              return const SizedBox.shrink();
                          }

                          // WICHTIG: Kein 'Column' verwenden! Einfach Padding und Text.
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0), // Kleiner Abstand zum Balken
                            child: Text(
                              _weekDays[index], // z.B. "16.01"
                              style: const TextStyle(
                                color: Colors.white, // Weißer Text
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  
                ),

                
                // Balken Design
                barGroups: _weeklyValues.asMap().entries.map((entry) {
                  int index = entry.key;
                  double value = entry.value;
                  
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        // Wenn Wert > 0, nimm Farbe, sonst transparent
                        color: value > 0 ? _getColorForMood(value) : Colors.transparent,
                        width: 12, // Balken etwas dünner für mehr Platz
                        borderRadius: BorderRadius.circular(4),
                        
                        // Hintergrund Balken (Leerer Platz)
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 5, 
                          color: Colors.white.withOpacity(0.05), // Sehr transparentes Weiß
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForMood(double value) {
    // Farben angepasst für Kontrast auf dunklem Hintergrund
    if (value <= 2) return AppColors.orangeEnd; // Schlecht -> Orange
    if (value <= 3.5) return AppColors.orangeStart; // Mittel -> Gelblich/Orange
    return Colors.white; // Gut -> Weiß (leuchtet am besten auf TealDark)
    // Alternativ: return AppColors.tealPrimary; wenn das hell genug ist
  }
}