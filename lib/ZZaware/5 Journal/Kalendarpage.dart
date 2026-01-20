import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
import 'package:projekt_i/main.dart'; 

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  // Hilfsfunktion: String Datum zurück zu DateTime parsen für Sortierung
  DateTime _parseDateString(String dateString) {
    try {
      List<String> parts = dateString.split('.');
      return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (e) {
      return DateTime(1970); // Fallback
    }
  }

  Stream<QuerySnapshot> _getJournalStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.empty();

    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('entries');

    if (_selectedDay != null) {
      return collection.where('date_string', isEqualTo: _formatDate(_selectedDay!)).snapshots();
    } else {
      return collection.orderBy('saved_at', descending: true).limit(30).snapshots();
    }
  }

  Stream<QuerySnapshot> _getGratitudeStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.empty();

    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('gratitude_entries');

    if (_selectedDay != null) {
      return collection.where('date_string', isEqualTo: _formatDate(_selectedDay!)).snapshots();
    } else {
      return collection.orderBy('saved_at', descending: true).limit(30).snapshots();
    }
  }

  // Bauplan für eine einzelne Karte
  Widget _buildEntryCard(Map<String, dynamic> data) {
    final isGratitude = data['type'] == 'gratitude';
    
    return Card(
      elevation: 0,
      color: AppColors.cardWhite,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isGratitude 
                ? AppColors.orangeStart.withOpacity(0.1) 
                : AppColors.tealPrimary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isGratitude ? Icons.favorite : Icons.article,
            color: isGratitude ? AppColors.orangeStart : AppColors.tealPrimary,
            size: 20,
          ),
        ),
        title: Text(
          (data['headline'] != null && data['headline'].toString().isNotEmpty) 
              ? data['headline'] 
              : (isGratitude ? "Dankbarkeit" : "Eintrag"),
          style: const TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              data['text'] ?? "", 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.text),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.tealPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 1; 

    return ResponsiveWrapper(
      selectedIndex: myCurrentIndex,
      onTabChange: (clickedIndex) {
        if (clickedIndex != myCurrentIndex) {
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
        backgroundColor: AppColors.bgLight,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // --- HEADER ---
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, size: 28),
                              color: AppColors.tealDark,
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => const ResponsiveLayout(initialIndex: 2),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Kalender",
                              style: TextStyle(color: AppColors.tealDark, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- KALENDER ---
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ]
                      ),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            if (isSameDay(_selectedDay, selectedDay)) {
                              _selectedDay = null; 
                            } else {
                              _selectedDay = selectedDay;
                            }
                            _focusedDay = focusedDay;
                          });
                        },
                        onFormatChanged: (format) => setState(() => _calendarFormat = format),
                        onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(color: AppColors.tealDark, fontSize: 17, fontWeight: FontWeight.bold),
                          leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.tealPrimary),
                          rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.tealPrimary),
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: const BoxDecoration(color: AppColors.tealPrimary, shape: BoxShape.circle),
                          todayDecoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.tealPrimary, width: 2),
                          ),
                          todayTextStyle: const TextStyle(color: AppColors.tealPrimary, fontWeight: FontWeight.bold),
                          defaultTextStyle: const TextStyle(color: AppColors.text),
                          weekendTextStyle: const TextStyle(color: AppColors.greyText),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- FILTER TITEL ---
                    if (_selectedDay != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gefiltert: ${_formatDate(_selectedDay!)}",
                              style: const TextStyle(color: AppColors.tealDark, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () => setState(() => _selectedDay = null),
                              child: const Text("Filter löschen", style: TextStyle(color: AppColors.tealPrimary, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

              

                    // --- GRUPPIERTE LISTE ---
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _getJournalStream(),
                        builder: (context, journalSnapshot) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: _getGratitudeStream(),
                            builder: (context, gratitudeSnapshot) {
                              
                              if (!journalSnapshot.hasData || !gratitudeSnapshot.hasData) {
                                return const Center(child: CircularProgressIndicator(color: AppColors.tealPrimary));
                              }

                              // 1. Daten Sammeln
                              List<Map<String, dynamic>> allEntries = [];

                              for (var doc in journalSnapshot.data!.docs) {
                                final data = doc.data() as Map<String, dynamic>;
                                data['type'] = 'journal';
                                allEntries.add(data);
                              }
                              for (var doc in gratitudeSnapshot.data!.docs) {
                                final data = doc.data() as Map<String, dynamic>;
                                data['type'] = 'gratitude';
                                allEntries.add(data);
                              }

                              if (allEntries.isEmpty) {
                                return Center(
                                  child: Text("Keine Einträge gefunden.", style: TextStyle(color: AppColors.greyText.withOpacity(0.7)))
                                );
                              }

                              // 2. Gruppieren nach Datum (date_string)
                              // Map Struktur: { "12.5.2024": [Entry1, Entry2], "11.5.2024": [Entry3] }
                              Map<String, List<Map<String, dynamic>>> groupedData = {};

                              for (var entry in allEntries) {
                                String dateKey = entry['date_string'] ?? "Unbekannt";
                                if (!groupedData.containsKey(dateKey)) {
                                  groupedData[dateKey] = [];
                                }
                                groupedData[dateKey]!.add(entry);
                              }

                              // 3. Keys (Datum) sortieren (Neueste zuerst)
                              List<String> sortedKeys = groupedData.keys.toList();
                              sortedKeys.sort((a, b) {
                                // Wir müssen die Strings zu DateTime machen, um korrekt zu sortieren
                                DateTime dateA = _parseDateString(a);
                                DateTime dateB = _parseDateString(b);
                                return dateB.compareTo(dateA); // Absteigend
                              });

                              // 4. Liste bauen
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: sortedKeys.length,
                                itemBuilder: (context, index) {
                                  String dateKey = sortedKeys[index];
                                  List<Map<String, dynamic>> entriesForDay = groupedData[dateKey]!;

                                  // Innerhalb des Tages sortieren: Journal zuerst, dann Dankbarkeit
                                  entriesForDay.sort((a, b) {
                                    String typeA = a['type'];
                                    String typeB = b['type'];
                                    if (typeA == 'journal' && typeB == 'gratitude') return -1;
                                    if (typeA == 'gratitude' && typeB == 'journal') return 1;
                                    return 0; // Wenn gleicher Typ
                                  });

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // --- DATUM ÜBERSCHRIFT ---
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                              dateKey, // z.B. 18.1.2026
                                              style: const TextStyle(
                                                color: AppColors.tealDark,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                letterSpacing: 0.5
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(child: Divider(color: AppColors.greyText.withOpacity(0.3))),
                                          ],
                                        ),
                                      ),

                                      // --- KARTEN FÜR DIESES DATUM ---
                                      ...entriesForDay.map((entry) {
                                        return _buildEntryCard(entry);
                                      }).toList(),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
