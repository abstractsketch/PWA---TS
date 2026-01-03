import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Bibliothek/Artikelinfo.dart';
import 'package:projekt_i/ZSections/Bibliothek/Dankbarkeit_Kat.dart';
import 'package:projekt_i/ZSections/Bibliothek/Suche.dart';

class Bibliothek extends StatefulWidget {
  const Bibliothek({super.key});

  @override
  State<Bibliothek> createState() => _BibliothekState();
}

class _BibliothekState extends State<Bibliothek> {
  Widget buildRow(
    String text1, Color? color1, String text2, Color? color2, double height) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UebersichtSeite(), // <-- eigene Seite
                  ),
                );
              },
              child: Container(
                height: height,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(text1)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UebersichtSeite(),
                  ),
                );
              },
              child: Container(
                height: height,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(text2)),
              ),
            ),
          ),
        ],
      );
    }


  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Bibliothek"),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: Suche(articles), // <-- dein Such-Delegate aus artikel_info.dart
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Suche',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.black54),
                  ],
                ),
              ),
            ),


          //Kategorieboxen 

          const SizedBox(height: 20),

          buildRow("Dankbarkeit", Colors.blue[200], "Box 2", Colors.green[200], 150),

          const SizedBox(height: 20),

          buildRow("Box 3", Colors.red[200], "Box 4", Colors.orange[200], 150),

          const SizedBox(height: 20),

          buildRow("Box 5", Colors.purple[200], "Box 6", Colors.teal[200], 150),

          const SizedBox(height: 20),

          buildRow("Box 7", Colors.pink[200], "Box 8", Colors.yellow[200], 150),

          const SizedBox(height: 20),

          buildRow("Box 9", Colors.indigo[200], "Box 10", Colors.cyan[200], 150),
        ],
      ),
    );
  }
}


/*class _BibliothekState extends State<Bibliothek> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AppBar(title: const Text("Bibliothek")),
        Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),  
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search'),
              Icon(
                Icons.search,
                color: Colors.grey[600],
              ),
            ]          
          )
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 1")),
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 2")),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Zweite Reihe
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.red[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 3")),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 4")),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Dritte Reihe
        Row(
          children: [
            Expanded(
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.purple[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 5")),
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.teal[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 6")),
              ),
            ),
            
            Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.red[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 3")),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 4")),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.red[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 3")),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[150],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Box 4")),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}

*/