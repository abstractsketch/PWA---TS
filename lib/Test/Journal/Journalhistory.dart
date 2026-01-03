import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class JournalHistoryScreen extends StatelessWidget {
  const JournalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final journalBox = Hive.box('journal');

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDF5),
      appBar: AppBar(
        title: const Text("Deine Gedanken", style: TextStyle(color: Colors.black, fontFamily: 'Serif')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: journalBox.listenable(),
        builder: (context, Box box, widget) {
          
          if (box.isEmpty) {
            return const Center(
              child: Text("Noch keine Einträge.\nSchreibe deinen ersten Gedanken!", 
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          List<int> keys = box.keys.cast<int>().toList(); 
          
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final int key = keys[keys.length - 1 - index];
              final Map entry = box.get(key);

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  title: Text(
                    entry['title'] ?? "Ohne Titel",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        entry['content'] ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(entry['date']),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          _getMoodIcon(entry['mood']),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      box.delete(key);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final DateTime date = DateTime.parse(isoDate);
      return "${date.day}.${date.month}.${date.year} - ${date.hour}:${date.minute} Uhr";
    } catch (e) {
      return "";
    }
  }

  Widget _getMoodIcon(int index) {
    IconData icon;
    Color color;
    switch (index) {
      case 0: icon = Icons.sentiment_very_satisfied; color = Colors.green; break;
      case 1: icon = Icons.sentiment_satisfied; color = Colors.lightGreen; break;
      case 2: icon = Icons.sentiment_neutral; color = Colors.amber; break;
      case 3: icon = Icons.sentiment_dissatisfied; color = Colors.orange; break;
      case 4: icon = Icons.sentiment_very_dissatisfied; color = Colors.red; break;
      default: icon = Icons.circle; color = Colors.grey;
    }
    return Icon(icon, color: color, size: 20);
  }
}