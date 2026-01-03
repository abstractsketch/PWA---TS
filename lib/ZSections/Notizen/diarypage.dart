import 'dart:math';
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final List<String> _questions = [
    "Wofür bist du heute dankbar?",
    "Was war dein schönster Moment heute?",
    "Welche Herausforderung hast du gemeistert?",
    "Was hast du heute über dich gelernt?",
    "Welche kleine Freude hast du dir gegönnt?",
    "Was möchtest du morgen besser machen?",
    "Welche Person hat dich heute inspiriert?",
  ];

  late String _currentQuestion;

  @override
  void initState() {
    super.initState();
    _currentQuestion = _getRandomQuestion();
  }

  String _getRandomQuestion() {
    final random = Random();
    return _questions[random.nextInt(_questions.length)];
  }

  void _shuffleQuestion() {
    setState(() {
      _currentQuestion = _getRandomQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tagebuchseite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _currentQuestion,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Schreibe deine Gedanken hier...",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _shuffleQuestion,
              icon: const Icon(Icons.casino),
              label: const Text("Neue Frage würfeln"),
            ),
          ],
        ),
      ),
    );
  }
}
