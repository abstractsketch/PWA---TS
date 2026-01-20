import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt_i/main.dart';



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
    final DateTime? date;


  const DailyPromptWidget({super.key, this.date});

  @override
  State<DailyPromptWidget> createState() => _DailyPromptWidgetState();
}

class _DailyPromptWidgetState extends State<DailyPromptWidget> {
  int _currentIndex = 0;
  final TextEditingController _textController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _shuffleQuestion();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _shuffleQuestion() {
    setState(() {
      _currentIndex = Random().nextInt(journalQuestions.length);
    });
  }

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";


  // --- SPEICHER LOGIK (Direkt hier integriert) ---
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
      final DateTime entryDate = widget.date ?? DateTime.now();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          .add({
        'headline': journalQuestions[_currentIndex],
        'tag': 'prompt',
        'text': _textController.text.trim(),
        'date_string': _formatDate(entryDate),
        'saved_at': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      // Erfolgsmeldung & Feld leeren
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erfolgreich gespeichert!'), 
          backgroundColor: AppColors.tealDark,
          duration: Duration(seconds: 2),
        ),
      );
      
      _textController.clear();
      // Optional: Neue Frage generieren nach dem Speichern
      // _shuffleQuestion(); 

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.tealPrimary, 
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.tealDark.withOpacity(0.3), 
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // 1. Dekorativer Kreis (Hintergrund oben rechts)
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // 2. Inhalt
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // OBERER TEIL: FRAGE
                      Row(
                        children: [
                          Text(
                            "IMPULS DES TAGES",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1.0,
                            ),
                          ),
                          const Spacer(),
                          // Shuffle Button oben rechts
                           IconButton(
                            icon: const Icon(Icons.refresh, color: Colors.white70, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: _shuffleQuestion,
                            tooltip: "Neue Frage",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        journalQuestions[_currentIndex],
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white, 
                          height: 1.3
                        ),
                      ),
                      
                      const SizedBox(height: 20),

                      // MITTLERER TEIL: EINGABEFELD (Weiß)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _textController,
                          minLines: 2,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Deine Gedanken dazu...',
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          style: const TextStyle(fontSize: 14, color: AppColors.text),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // UNTERER TEIL: SPEICHERN BUTTON (Rechtsbündig)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.orangeStart, AppColors.orangeEnd],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(22), // Runder Button Look
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _isSaving ? null : _saveEntry,
                            icon: _isSaving 
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                                : const Icon(Icons.check, size: 18, color: Colors.white),
                            label: Text(
                              _isSaving ? "Speichert..." : "Eintrag speichern",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// LISTE ALLER FRAGEN (Bleibt gleich, nur zum Nachschlagen)
// ---------------------------------------------------------

class QuestionsListPage extends StatelessWidget {
  const QuestionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Alle Anreize', style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.tealPrimary),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: journalQuestions.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.cardWhite,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.tealPrimary.withOpacity(0.2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(journalQuestions[index], style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.text)),
              // Hier könnte man auch direkt das Widget öffnen oder zur alten AnswerPage verlinken,
              // wenn man die Fragen aus der Liste beantworten will.
            ),
          );
        },
      ),
    );
  }
}