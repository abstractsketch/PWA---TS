import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/Userscreen.dart';

const Color kBackgroundColor = Colors.white; 
const Color kPrimaryGreen = Color(0xFF608665);
const Color kCardColor = Color(0xFFF9F9F9);
const Color kTextDark = Color(0xFF2E3D31);

class Testjournal extends StatefulWidget {
  @override
  _TestjournalState createState() => _TestjournalState();
}

class _TestjournalState extends State<Testjournal> {
  final _headlineController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _currentWeek = [];

  @override
  void initState() {
    super.initState();
    _generateCurrentWeek();
  }

  void _generateCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    _currentWeek = List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (_headlineController.text.isEmpty && _contentController.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('entries').add({
        'headline': _headlineController.text.trim(),
        'text': _contentController.text.trim(),
        'date_string': _formatDate(_selectedDate),
        'saved_at': FieldValue.serverTimestamp(),
      });
      _headlineController.clear();
      _contentController.clear();
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gespeichert!"), backgroundColor: kPrimaryGreen));
    } catch (e) { print(e); }
  }

  @override
  Widget build(BuildContext context) {
    final days = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"];
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kPrimaryGreen),
        actions: [
          IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))),
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 90,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _currentWeek.length,
              itemBuilder: (context, index) {
                final date = _currentWeek[index];
                final isSelected = _formatDate(date) == _formatDate(_selectedDate);
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 55,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? kPrimaryGreen : kCardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: isSelected ? kPrimaryGreen : kPrimaryGreen.withOpacity(0.1)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(days[date.weekday - 1], style: TextStyle(color: isSelected ? Colors.white : kPrimaryGreen, fontWeight: FontWeight.bold)),
                        Text("${date.day}", style: TextStyle(color: isSelected ? Colors.white : kPrimaryGreen)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Neuer Eintrag: ${_formatDate(_selectedDate)}", style: TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
                  SizedBox(height: 15),
                  TextField(
                    controller: _headlineController,
                    decoration: InputDecoration(filled: true, fillColor: kCardColor, hintText: "Überschrift", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _contentController,
                    maxLines: 3,
                    decoration: InputDecoration(filled: true, fillColor: kCardColor, hintText: "Gedanken...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _saveData,
                    icon: Icon(Icons.add),
                    label: Text("Hinzufügen"),
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                  SizedBox(height: 30),
                  Text("Deine Einträge", style: TextStyle(color: kPrimaryGreen, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  if (user != null)
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('entries').orderBy('saved_at', descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return LinearProgressIndicator(color: kPrimaryGreen);
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                subtitle: Text(data['text'] ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
                                trailing: Icon(Icons.chevron_right, color: kPrimaryGreen),
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EntryDetailPage(data: data))),
                              ),
                            );
                          },
                        );
                      },
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}