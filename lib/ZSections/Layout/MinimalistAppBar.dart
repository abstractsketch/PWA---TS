import 'package:flutter/material.dart';

class MinimalistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MinimalistAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    // Dunkles Blau/Grau für Text und Icons
    final Color contentColor = const Color(0xFF0D1F2D);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 900;

    return AppBar(
      backgroundColor: const Color(0xFFE3E3DD), // Gleiche Farbe wie Body
      elevation: 0, // Kein Schatten für den "flachen" Look
      scrolledUnderElevation: 0,
      
      // --- 1. LOGO (LINKS) ---
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Icon(
          Icons.change_history_outlined, // Platzhalter für das Dreieck/Kreis Logo
          color: contentColor,
          size: 40,
        ),
      ),
      centerTitle: false, // Wichtig: Logo bleibt links

      // --- 2. NAVIGATION & ICONS (RECHTS) ---
      actions: [
        
        // Desktop-Ansicht: Text-Links anzeigen
        if (isDesktop) ...[
          _NavBarLink(text: "ARTICLES", color: contentColor),
          _NavBarLink(text: "BOOK", color: contentColor),
          _NavBarLink(text: "CARDS", color: contentColor),
          _NavBarLink(text: "INFO", color: contentColor),
          _NavBarLink(text: "STORE", color: contentColor, showArrow: true),
          
          const SizedBox(width: 40), // Abstand zu den Utility Icons
        ],

        // Utility Icons (Mond & Sprache) - Immer sichtbar
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.dark_mode_outlined, color: contentColor, size: 20),
        ),
        
        const SizedBox(width: 20),
        
        // Sprachauswahl
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Icon(Icons.language, color: contentColor, size: 18),
              const SizedBox(width: 8),
              Text(
                "ENGLISH",
                style: TextStyle(
                  color: contentColor,
                  fontFamily: 'Courier', // Monospace Font
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: contentColor),
            ],
          ),
        ),

        // Mobile-Ansicht: Hamburger Menü statt Text-Links
        if (!isDesktop) ...[
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.menu, color: contentColor),
            onPressed: () {
              // Drawer öffnen
            },
          ),
        ],

        const SizedBox(width: 30), // Rechter Randabstand
      ],
    );
  }
}

// --- Hilfs-Widget für die Links ---
class _NavBarLink extends StatelessWidget {
  final String text;
  final Color color;
  final bool showArrow;

  const _NavBarLink({
    required this.text,
    required this.color,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          overlayColor: Colors.transparent, // Kein Splash-Effekt für Clean-Look
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: color,
                fontFamily: 'Courier', // WICHTIG: Monospace für den Look
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 1.5, // Buchstabenabstand wie im Bild
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.north_east, size: 12, color: color), // Der kleine Pfeil
            ]
          ],
        ),
      ),
    );
  }
}