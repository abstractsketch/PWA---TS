import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart' hide AppColors;
import 'package:projekt_i/main.dart';

// --- ARTIKEL MODEL ---
class Article {
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String content;
  final String authorName;
  final String authorImg;
  final String readTime;
  final DateTime date;
  final String? highlightQuote;

  Article({
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.content,
    this.authorName = "Redaktion", 
    this.authorImg = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80", 
    required this.readTime,
    required this.date, 
    this.highlightQuote,
  });
}

// --- DIE NEUE DESIGN SEITE (Blog Style) ---
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 2; 

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
        backgroundColor: const Color(0xFFF4F6F8), // Sauberer weißer Hintergrund wie im Bild
        body: SafeArea(
          child: Stack(
            children: [
              // --- SCROLLBARER INHALT ---
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200), // Begrenzte Breite für Lesbarkeit
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            // --- 1. DAS BILD (Mit abgerundeten Ecken) ---
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(article.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                  
                            const SizedBox(height: 32),
                  
                            // --- 2. TAG & LESEZEIT ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Gradient Tag (Orange/Pink)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.orangeStart, AppColors.orangeEnd],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    article.category.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                  
                                // Lesezeit
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: AppColors.greyText),
                                    const SizedBox(width: 4),
                                    Text(
                                      article.readTime, 
                                      style: const TextStyle(color: AppColors.greyText, fontSize: 13)
                                    ),
                                  ],
                                )
                              ],
                            ),
                  
                            const SizedBox(height: 20),
                  
                            // --- 3. TITEL (Groß & Teal) ---
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Text(
                                article.title,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.tealDark, // Die dunkle Teal Farbe aus dem Bild
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                  
                            const SizedBox(height: 24),
                  
                            // --- 4. AUTOR & DATUM ---
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(article.authorImg),
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.authorName,
                                      style: const TextStyle(
                                        color: AppColors.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _formatDate(article.date),
                                      style: const TextStyle(
                                        color: AppColors.tealPrimary, // Datum in Teal
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                  
                            const SizedBox(height: 30),
                            
                            // Feine Trennlinie
                            Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
                            
                            const SizedBox(height: 30),
                  
                            // --- 5. CONTENT BODY ---
                            
                            // Intro / Subtitle (Teal)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                article.description, // Dient hier als Zwischenüberschrift
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.tealDark, 
                                ),
                              ),
                            ),
                  
                            const SizedBox(height: 5),
                  
                            // Fließtext
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                article.content,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.text, 
                                  fontWeight: FontWeight.w400,
                              
                                ),
                              ),
                            ),
                            
                            // Zitat Box (Optional, falls vorhanden)
                            if (article.highlightQuote != null) ...[
                              const SizedBox(height: 24),
                               Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.bgLight,
                                  border: const Border(left: BorderSide(color: AppColors.orangeStart, width: 4)),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text(
                                  article.highlightQuote!,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                            ],
                  
                            const SizedBox(height: 50), // Platz am Ende
                          ],
                        ),
                      ),
                    ),
                ),
                ),

              // --- ZURÜCK BUTTON (Floating) ---
              // Da das Bild nicht mehr ganz oben ist, passt ein kleiner Button oben links gut.
              Positioned(
                top: 10,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.arrow_back, color: AppColors.tealDark, size: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }
}