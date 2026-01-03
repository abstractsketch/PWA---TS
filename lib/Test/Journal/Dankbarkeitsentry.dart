import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dankbarkeitsentry extends StatefulWidget {
  const Dankbarkeitsentry({super.key});

  @override
  State<Dankbarkeitsentry> createState() => _DankbarkeitsentryState();
}

class _DankbarkeitsentryState extends State<Dankbarkeitsentry> {

  static const Color primaryGreen = Color(0xFF6B8E70);
  static const Color darkTextColor = Color(0xFF2D2D2D);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _addExampleQuestions() {
    final String currentText = _bodyController.text;
    
    String newQuestions = 
        "1. Welche kleine Geste hat mich heute gefreut?\n\n\n"
        "2. Für welche Person in meinem Leben bin ich dankbar und warum?\n\n\n"
        "3. Was ist eine Eigenschaft an mir selbst, die ich wertschätze?\n\n";

    String prefix = currentText.isNotEmpty ? "\n\n---\n\n" : "";

    setState(() {
      _bodyController.text = "$currentText$prefix$newQuestions";
      _bodyController.selection = TextSelection.fromPosition(
        TextPosition(offset: _bodyController.text.length),
      );
    });
  }

  Future<void> _saveEntry() async {
    final String title = _titleController.text.trim();
    final String body = _bodyController.text.trim();

    if (title.isEmpty && body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Das Formular ist leer. Wofür bist du dankbar?')),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isSaving = true;
    });

    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Du bist nicht eingeloggt.");
      }

      final DateTime now = DateTime.now();

      // WICHTIG: Wir speichern hier in 'gratitude_entries' statt 'journal_entries'
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('gratitude_entries') 
          .add({
            'title': title.isEmpty ? 'Dankbarkeit' : title,
            'body': body,
            'date': now,
            'created_at': FieldValue.serverTimestamp(),
            'day': now.day,
            'month': now.month,
            'year': now.year,
          });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dankbarkeitseintrag gespeichert!'),
          backgroundColor: primaryGreen,
        ),
      );
      
      Navigator.pop(context);

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Dankbarkeit", style: TextStyle(color: darkTextColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkTextColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: "Ich bin heute dankbar für...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _addExampleQuestions,
                    icon: const Icon(Icons.favorite_border, size: 20), 
                    label: const Text("Impulse"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryGreen,
                      side: const BorderSide(color: primaryGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: primaryGreen.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: _isSaving 
                      ? const SizedBox(
                          width: 20, 
                          height: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, size: 20), 
                            SizedBox(width: 8),
                            Text("Fertig"),
                          ],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}