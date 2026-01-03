import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color kBackgroundColor = Colors.white; 
const Color kPrimaryGreen = Color(0xFF608665); 
const Color kCardColor = Color(0xFFF9F9F9);
const Color kTextDark = Color(0xFF2E3D31);

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  Stream<QuerySnapshot> _getEntriesStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.empty();

    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('entries');

    if (_selectedDay != null) {
      return collection
          .where('date_string', isEqualTo: _formatDate(_selectedDay!))
          .snapshots();
    } 
    else {
      return collection
          .orderBy('saved_at', descending: true)
          .limit(20)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Kalender", style: TextStyle(color: kTextDark)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kPrimaryGreen),
      ),
      body: Column(
        children: [
          TableCalendar(
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

            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: kTextDark, fontSize: 17, fontWeight: FontWeight.bold),
              leftChevronIcon: Icon(Icons.chevron_left, color: kPrimaryGreen),
              rightChevronIcon: Icon(Icons.chevron_right, color: kPrimaryGreen),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: kPrimaryGreen,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryGreen, width: 2),
              ),
              todayTextStyle: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold),
              defaultTextStyle: TextStyle(color: kTextDark),
              weekendTextStyle: TextStyle(color: Colors.grey),
            ),
          ),
          
          SizedBox(height: 10),
          Divider(color: Colors.grey[300]),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Text(
                  _selectedDay != null
                      ? "Einträge vom ${_formatDate(_selectedDay!)}"
                      : "Vorherige Einträge",
                  style: TextStyle(
                      color: kPrimaryGreen, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                
                if (_selectedDay != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDay = null;
                      });
                    },
                    child: Text(
                      "Alle zeigen",
                      style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getEntriesStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator(color: kPrimaryGreen));
                
                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                   return Center(
                     child: Text(
                       "Keine Einträge gefunden.", 
                       style: TextStyle(color: Colors.grey),
                     )
                   );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    
                    return Card(
                      elevation: 0,
                      color: kCardColor,
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(data['headline'] ?? "", style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['text'] ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 4),
                            if (_selectedDay == null)
                              Text(data['date_string'] ?? "", style: TextStyle(fontSize: 10, color: Colors.grey))
                          ],
                        ),
                        trailing: Icon(Icons.chevron_right, color: kPrimaryGreen),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}