class Artikel {
  final String title;
  final String content;
  final List<String> tags;

  Artikel({required this.title, required this.content, required this.tags});
}

final List<Artikel> articles = [
  Artikel(
    title: "Emotional Intelligenz",
    content: "Einführung in Flutter und Dart...",
    tags: ["emotionen", "emotionale intelligenz", "intelligenz"],
  ),
  Artikel(
    title: "Angst verstehen",
    content: "Provider, Riverpod und Bloc erklärt...",
    tags: ["emotionen", "angst", "stress"],
  ),
];
