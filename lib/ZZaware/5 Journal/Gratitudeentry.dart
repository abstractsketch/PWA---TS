import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projekt_i/ZSections/Bibliothek/Bibliothek.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
import 'package:projekt_i/ZZaware/4%20Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/main.dart'; 

class Gratitudeentry extends StatefulWidget {
  final DateTime? date;

  const Gratitudeentry({super.key, this.date});
  @override
  State<Gratitudeentry> createState() => GratitudeentryState();
}

class GratitudeentryState extends State<Gratitudeentry> {
  final _headlineController = TextEditingController();
  final _contentController = TextEditingController();
  
  bool _isSaving = false;
  bool _isLoading = true; 
  String? _existingDocId; 

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  @override
  void initState() {
    super.initState();
    _checkForExistingEntry(); // <--- NEU: Beim Start prüfen
  }

  Future<void> _checkForExistingEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final DateTime entryDate = widget.date ?? DateTime.now();
    final String dateString = _formatDate(entryDate);

    try {
      // Abfrage: User -> entries -> wo Datum stimmt UND es ein Gratitude-Eintrag ist
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          .where('date_string', isEqualTo: dateString)
          .where('tag', isEqualTo: 'gratitude') // Wichtig, damit wir nicht andere Eintragstypen laden
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        
        setState(() {
          _existingDocId = doc.id; // ID speichern für späteres Update
          _contentController.text = data['text'] ?? ""; // Text laden
          
          // Optional: Cursor ans Ende des Textes setzen
          /*_contentController.selection = TextSelection.fromPosition(
            TextPosition(offset: _contentController.text.length)
          );*/
        });
      }
    } catch (e) {
      debugPrint("Fehler beim Laden des Eintrags: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; 
        });
      }
    }
  }

  Future<void> _saveEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_headlineController.text.trim().isEmpty && _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte gib einen Text oder Titel ein.")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final DateTime entryDate = widget.date ?? DateTime.now();
      
      // Referenz zur Collection
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries');

      // <--- NEU: Unterscheidung zwischen Update und Create
      if (_existingDocId != null) {
        // UPDATE: Existierenden Eintrag aktualisieren
        await collectionRef.doc(_existingDocId).update({
          'text': _contentController.text.trim(),
          'saved_at': FieldValue.serverTimestamp(), // Zeitstempel der letzten Änderung
          // 'headline' und 'date_string' müssen meist nicht geupdated werden
        });
      } else {
        // CREATE: Neuen Eintrag erstellen (so wie vorher)
        await collectionRef.add({
          'headline': 'Dankbarkeitstagebuch',
          'tag': 'gratitude',
          'text': _contentController.text.trim(),
          'date_string': _formatDate(entryDate),
          'saved_at': FieldValue.serverTimestamp(),
        });
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Eintrag gespeichert!"), 
          backgroundColor: AppColors.tealPrimary 
        ),
      );
      
      // Nach dem Speichern könnte man hier optional die Seite verlassen
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
    _headlineController.dispose(); // Wichtig: Auch diesen Controller disposen
    _contentController.dispose();
    super.dispose();
  }

  void _addExampleQuestions() {
    final String currentText = _contentController.text;
    
    String newQuestions = 
        "Über welche kleine Geste hast du dich heute gefreut?\n\n\n"
        "Für welche Person in deinem Leben bist du dankbar und warum?\n\n\n"
        "Was ist eine Eigenschaft an dir selbst, die du wertschätzt?\n\n\n";

    String prefix = currentText.isNotEmpty ? "\n\n---\n\n" : "";

    setState(() {
      _contentController.text = "$currentText$prefix$newQuestions";
      _contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: _contentController.text.length),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final displayDate = widget.date ?? DateTime.now();
    const int myCurrentIndex = 2; 

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bgLight,
        body: Center(child: CircularProgressIndicator(color: AppColors.tealPrimary)),
      );
    }

    return ResponsiveWrapper(
      selectedIndex: myCurrentIndex,
      onTabChange: (clickedIndex) {
        if (clickedIndex == myCurrentIndex) {
          Navigator.pop(context);
        } else {
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                                        Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), 
                        child: Row(
                          mainAxisSize: MainAxisSize.min, 
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, size: 28),
                              color: AppColors.tealDark,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => const ResponsiveLayout(initialIndex: 1),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 4), 
                            Text(
                              _existingDocId != null ? "Eintrag bearbeiten" : "Neuer Eintrag",
                              style: const TextStyle(
                                color: AppColors.tealDark, 
                                fontSize: 20, 
                                fontWeight: FontWeight.bold 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    Center(
                      child: Text(
                        _formatDate(displayDate),
                        style: const TextStyle(color: AppColors.tealDark, fontSize: 14), 
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("Wofür bist du dankbar?", style: const TextStyle(color: AppColors.tealDark, fontSize: 20),),
                    
                    const SizedBox(height: 12),
            
                    // Text Inhalt Feld
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        
                        style: const TextStyle(color: AppColors.text), 
                        cursorColor: AppColors.tealPrimary,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.cardWhite, 
                          hoverColor: Colors.transparent, 
                          hintText: "Ich bin heute dankbar für ...",
                          hintStyle: TextStyle(color: AppColors.greyText.withOpacity(0.7)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
            
                    const SizedBox(height: 20),
            
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.orangeStart, AppColors.orangeEnd],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(22), 
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _addExampleQuestions,
                            icon: const Icon(Icons.question_mark, size: 18, color: Colors.white),
                            label: Text( "Fragen",
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
                            borderRadius: BorderRadius.circular(22), 
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