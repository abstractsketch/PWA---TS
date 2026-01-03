import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Bibliothek/Artikelinfo.dart';

class Suche extends SearchDelegate<Artikel?> {
  final List<Artikel> allArticles;

  Suche(this.allArticles);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allArticles.where((article) {
      final lowerQuery = query.toLowerCase();
      return article.title.toLowerCase().contains(lowerQuery) ||
             article.content.toLowerCase().contains(lowerQuery) ||
             article.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(
            article.content, 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            close(context, article); // Artikel zurückgeben
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allArticles.where((article) {
      final lowerQuery = query.toLowerCase();
      return article.title.toLowerCase().contains(lowerQuery) ||
             article.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final article = suggestions[index];
        return ListTile(
          title: Text(article.title),
          onTap: () {
            query = article.title;
            showResults(context);
          },
        );
      },
    );
  }
}
