import 'package:flutter/material.dart';

class DailyQuoteBox extends StatefulWidget {
  const DailyQuoteBox({super.key});

  @override
  State<DailyQuoteBox> createState() => _DailyQuoteBoxState();
}

class _DailyQuoteBoxState extends State<DailyQuoteBox> {
  final List<String> quotes = [
    "„Es ist nicht zu wenig Zeit, die wir haben, sondern es ist zu viel Zeit, die wir nicht nutzen.“",
    "In der Ruhe liegt die Kraft.",
    "Jeder Tag ist eine neue Chance.",
    "Träume groß, arbeite hart.",
    "Mut steht am Anfang des Handelns."
  ];

  late String todayQuote;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Index aus Datum berechnen → jeden Tag ein anderes Zitat
    final index = now.day % quotes.length;
    todayQuote = quotes[index];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                "Zitat des Tages:",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                todayQuote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
