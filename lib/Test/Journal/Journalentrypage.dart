import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color kBackgroundColor = Colors.white;
const Color kPrimaryGreen = Color(0xFF608665);
const Color kCardColor = Color(0xFFF9F9F9);
const Color kTextDark = Color(0xFF2E3D31);

class Journalentrypage extends StatefulWidget {
  final DateTime? date;

  const Journalentrypage({super.key, this.date});
  @override
  State<Journalentrypage> createState() => _JournalentrypageState();
}

class _JournalentrypageState extends State<Journalentrypage> {
  final _headlineController = TextEditingController();
  final _contentController = TextEditingController();
  
  bool _isSaving = false;

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  Future<void> _saveEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_headlineController.text.trim().isEmpty && _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte gib zumindest einen Text oder Titel ein.")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final DateTime entryDate = widget.date ?? DateTime.now();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          .add({
        'headline': _headlineController.text.trim(),
        'text': _contentController.text.trim(),
        'date_string': _formatDate(entryDate),
        'saved_at': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Eintrag gespeichert!"), backgroundColor: kPrimaryGreen),
      );
      
      // wenn seite schließen nach Speichern
      // Navigator.pop(context); 

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler: $e"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = widget.date ?? DateTime.now();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      // resizeToAvoidBottomInset: true sorgt dafür, dass die UI hochrutscht, wenn die Tastatur kommt
      appBar: AppBar(
        title: const Text("Neuer Eintrag", style: TextStyle(color: kTextDark)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryGreen),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  _formatDate(displayDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _headlineController,
                style: const TextStyle(color: kTextDark, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Überschrift",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              
              const SizedBox(height: 12),

              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null, // Unbegrenzte Zeilen
                  expands: true,  // Zwingt das Feld, den Parent (Expanded) auszufüllen
                  textAlignVertical: TextAlignVertical.top, // Text beginnt oben links
                  
                  style: const TextStyle(color: kTextDark),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: "Schreibe deine Gedanken hier auf...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveEntry,
                  icon: _isSaving 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                      : const Icon(Icons.check),
                  label: Text(
                    _isSaving ? "Speichert..." : "Eintrag speichern", 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}