import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projekt_i/ZSections/Authentifikation/firestore.dart';

class Reflektion extends StatefulWidget {
  const Reflektion({super.key});

  @override
  State<Reflektion> createState() => _ReflektionState();
}

class _ReflektionState extends State<Reflektion> {
  final TextEditingController textController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  Map<String, String> _entries = {};
  String _selectedDate = DateTime.now().toIso8601String().split("T")[0];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("my_entries") ?? "{}";

    setState(() {
      _entries = Map<String, String>.from(jsonDecode(jsonString));
      textController.text = _entries[_selectedDate] ?? "";
    });
  }

  Future<void> _saveEntry() async {
    final prefs = await SharedPreferences.getInstance();
    _entries[_selectedDate] = textController.text;
    await prefs.setString("my_entries", jsonEncode(_entries));
    setState(() {});
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_selectedDate),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked.toIso8601String().split("T")[0];
        textController.text = _entries[_selectedDate] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Datum: $_selectedDate",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            )),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: _pickDate,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text("Datum wählen"),
        ),

        const SizedBox(height: 16),

        TextField(
          controller: textController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: "Notiz für dieses Datum",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            _saveEntry();
            firestoreService.addNote(textController.text);
            textController.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text("Speichern"),
        ),

        const SizedBox(height: 20),

        Text("Gespeicherte Notizen:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            )),

        const SizedBox(height: 8),

        ..._entries.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text("${entry.key}: ${entry.value}"),
            )),
      ],
    );
  }
}
