import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Notizen/Notizen.dart';
import 'package:projekt_i/ZSections/Notizen/notizenwidget.dart';
import 'package:table_calendar/table_calendar.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// --- BUTTONS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton(
                  label: "Dankbarkeitsjournal",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Notizen()));
                  },
                ),
                _buildNavButton(
                  label: "Journal",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => NotizenWidget()));
                  },
                ),
              ],
            ),

            SizedBox(height: 24),

            /// --- VORHERIGE EINTRÄGE + KALENDER ---
            Text(
              "Vorherige Einträge",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SizedBox(height: 24),

            /// --- ARTIKEL SLIDER ---
            Text(
              "Artikelvorschläge",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildArticleCard(
                    imageUrl: "https://picsum.photos/300/200",
                    text: "Wie du deine Ziele erreichst und motiviert bleibst.",
                  ),
                  _buildArticleCard(
                    imageUrl: "https://picsum.photos/301/200",
                    text: "5 Tipps für ein positives Mindset im Alltag.",
                  ),
                  _buildArticleCard(
                    imageUrl: "https://picsum.photos/302/200",
                    text: "Warum Journaling dein Leben verbessern kann.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- BUTTON WIDGET ---
  Widget _buildNavButton({required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// --- ARTIKEL CARD ---
  Widget _buildArticleCard({required String imageUrl, required String text}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}


/// Dummy Klassen für Navigation
class Dankbarkeitsjournal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Dankbarkeitsjournal")));
  }
}


