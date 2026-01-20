import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projekt_i/main.dart'; 

class DailyEntriesList extends StatelessWidget {
  final DateTime? date;

  // Wir übergeben KEINEN Tag mehr im Konstruktor, damit ALLE geladen werden.
  const DailyEntriesList({super.key, this .date});

  String _formatDate(DateTime date) => "${date.day}.${date.month}.${date.year}";

  // Sortier-Logik: Kleine Zahl = Weiter oben in der Liste
  int _getSortPriority(String? tag) {
    // Sicherstellen, dass Groß-/Kleinschreibung egal ist
    final t = tag?.toLowerCase().trim() ?? '';
    
    if (t == 'journal') return 0;   // 1. Platz: Journal
    if (t == 'gratitude') return 1; // 2. Platz: Dankbarkeit
    return 2;                       // 3. Platz: Alles andere
  }

  // Design-Logik (Farben & Icons)
  Map<String, dynamic> _getStyle(String? tag) {
    final t = tag?.toLowerCase().trim() ?? '';
    
    if (t == 'journal') {
      return {
        'color': AppColors.orangeStart,
        'icon': Icons.menu_book_rounded,
        'title': 'Journal Eintrag'
      };
    } else if (t == 'gratitude') {
      return {
        'color': AppColors.tealPrimary, 
        'icon': Icons.favorite_rounded,
        'title': 'Dankbarkeit'
      };
    } else {
      return {
        'color': Colors.grey.shade700, 
        'icon': Icons.article_rounded,
        'title': 'Notiz'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          // WICHTIG: KEIN .where('tag', ...) hier! Wir wollen alle!
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Fehler: ${snapshot.error}");
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Keine Einträge für diesen Tag.", style: TextStyle(color: Colors.grey)),
            ),
          );
        }

        // --- SORTIERUNG ---
        // Liste kopieren, damit wir sie sortieren können
        List<QueryDocumentSnapshot> sortedDocs = List.from(docs);

        sortedDocs.sort((a, b) {
          final dataA = a.data() as Map<String, dynamic>;
          final dataB = b.data() as Map<String, dynamic>;

          final tagA = dataA['tag'] as String?;
          final tagB = dataB['tag'] as String?;

          // 1. Priorität vergleichen (Journal < Gratitude < Rest)
          int prioA = _getSortPriority(tagA);
          int prioB = _getSortPriority(tagB);

          if (prioA != prioB) {
            return prioA.compareTo(prioB);
          }

          // 2. Wenn Prio gleich ist (z.B. 2x Journal), dann nach Zeit sortieren
          // (Neueste zuerst)
          Timestamp? timeA = dataA['saved_at'] as Timestamp?;
          Timestamp? timeB = dataB['saved_at'] as Timestamp?;
          
          // Fallback, falls kein Timestamp da ist (DateTime.now)
          final tA = timeA?.toDate() ?? DateTime(2000);
          final tB = timeB?.toDate() ?? DateTime(2000);

          return tB.compareTo(tA); // B mit A vergleichen für absteigende Sortierung (neueste oben)
        });

        // --- LISTE ANZEIGEN ---
        return ListView.builder(
          // WICHTIG FÜR SCROLLEN IN COLUMN:
          shrinkWrap: true, 
          // WICHTIG: Physics auf NeverScrollable setzen, wenn das Eltern-Widget (z.B. die Seite) schon scrollbar ist.
          // Wenn die Liste ALLEIN scrollen soll, nimm 'BouncingScrollPhysics' und entferne shrinkWrap.
          physics: const NeverScrollableScrollPhysics(), 
          
          itemCount: sortedDocs.length,
          itemBuilder: (context, index) {
            final doc = sortedDocs[index];
            final data = doc.data() as Map<String, dynamic>;
            
            final String text = data['text'] ?? '';
            final String tag = data['tag'] ?? 'other';
            
            final style = _getStyle(tag);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4), // Etwas Abstand
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: style['color'].withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(style['icon'], color: style['color']),
                ),
                title: Text(
                  style['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: style['color'],
                  ),
                ),
                subtitle: Text(
                  text.replaceAll("\n", " "), // Zeilenumbrüche für Vorschau entfernen
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87),
                ),
                isThreeLine: true,
                onTap: () {
                  // Navigation Logik hier...
                  // print("Tapped on $tag entry");
                },
              ),
            );
          },
        );
      },
    );
  }
}