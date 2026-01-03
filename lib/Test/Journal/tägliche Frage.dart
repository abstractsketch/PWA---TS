import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color kPrimaryGreen = Color(0xFF608665);
const Color kBackground = Colors.white;
const Color kCardColor = Colors.white;
const Color kTextDark = Color(0xFF2E3D31);

final List<String> journalQuestions = [
  "Was ist ein Ziel, das ich für das kommende Jahr habe?",
  "Wofür bin ich heute besonders dankbar?",
  "Was war die größte Herausforderung dieser Woche?",
  "Welche kleine Sache hat mir heute Freude bereitet?",
  "Wenn ich eine Sache ändern könnte, was wäre das?",
  "Welche Eigenschaften schätze ich an mir selbst?",
  "Wer hat mich zuletzt inspiriert und warum?",
  "Was würde ich tun, wenn ich nicht scheitern könnte?",
  "Welchen Rat würde ich meinem jüngeren Ich geben?",
  "Was bedeutet Erfolg für mich persönlich?",
];

class DailyPromptWidget extends StatefulWidget {
  const DailyPromptWidget({super.key});

  @override
  State<DailyPromptWidget> createState() => _DailyPromptWidgetState();
}

class _DailyPromptWidgetState extends State<DailyPromptWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _shuffleQuestion();
  }

  void _shuffleQuestion() {
    setState(() {
      _currentIndex = Random().nextInt(journalQuestions.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Täglicher Anreiz',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextDark, fontFamily: 'Serif'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionsListPage())),
              child: const Text('Mehr anzeigen', style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: kPrimaryGreen),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                journalQuestions[_currentIndex],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kTextDark, height: 1.4),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: _shuffleQuestion,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kPrimaryGreen,
                      side: const BorderSide(color: kPrimaryGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(12),
                      minimumSize: const Size(48, 48),
                    ),
                    child: const Icon(Icons.shuffle, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnswerPage(question: journalQuestions[_currentIndex]),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                      child: const Text('Auf Anreiz antworten', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionsListPage extends StatelessWidget {
  const QuestionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Alle Anreize', style: TextStyle(color: kTextDark)),
        backgroundColor: kBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryGreen),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: journalQuestions.length,
        itemBuilder: (context, index) {
          return Card(
            color: kCardColor,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: kPrimaryGreen.withOpacity(0.1)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(journalQuestions[index], style: const TextStyle(fontWeight: FontWeight.w600, color: kTextDark)),
              trailing: const Icon(Icons.edit, size: 20, color: kPrimaryGreen),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnswerPage(question: journalQuestions[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AnswerPage extends StatefulWidget {
  final String question;
  const AnswerPage({super.key, required this.question});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isSaving = false;

  String _getFormattedDate() {
    final now = DateTime.now();
    return "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
  }

  Future<void> _saveEntry() async {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte schreibe erst etwas dazu.')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Du musst eingeloggt sein, um zu speichern.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          .add({
        'headline': widget.question,
        'text': _textController.text.trim(),
        'date_string': _getFormattedDate(),
        'saved_at': FieldValue.serverTimestamp(),
        'type': 'prompt',
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eintrag erfolgreich gespeichert!'), backgroundColor: kPrimaryGreen),
      );
      
      Navigator.pop(context);

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Speichern: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Eintrag', style: TextStyle(color: kTextDark)),
        backgroundColor: kBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryGreen,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _textController,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Schreibe deine Gedanken hier auf...',
                  filled: true,
                  fillColor: kCardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
    );
  }
}