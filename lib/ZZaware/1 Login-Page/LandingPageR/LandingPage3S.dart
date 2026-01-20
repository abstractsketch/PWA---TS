import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart';

class AppColors {
  static const Color tealPrimary = Color(0xFF28869E);
  static const Color tealDark = Color(0xFF1B5E6F);
  static const Color orangeStart = Color(0xFFFF9966);
  static const Color orangeEnd = Color(0xFFFF5E62);
  static const Color bgLight = Color(0xFFF0F4F6);
  static const Color cardWhite = Colors.white;
}

// ---------------------------------------------------------------------------
// 3. DIE LANDING PAGE
// ---------------------------------------------------------------------------
class LandingPage3S extends StatelessWidget {
  const LandingPage3S({super.key});

  // Hilfsmethode zur Navigation zum AuthScreen
  void _navigateToAuth(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final double contentWidth = isDesktop ? 1000 : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      // OBERE NAVIGATION (Header)
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        titleSpacing: isDesktop ? 40 : 20,
        title: Row(
          children: [
            const Icon(Icons.remove_red_eye, color: AppColors.tealPrimary),
            const SizedBox(width: 10),
            Text(
              "aware.",
              style: TextStyle(
                color: AppColors.tealDark,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isDesktop ? 40 : 20),
            child: Row(
              children: [
                // Login Button (Text)
                TextButton(
                  onPressed: () => _navigateToAuth(context),
                  child: Text(
                    "Login",
                    style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 15),
                // Registrieren Button (Gradient)
                _GradientButton(
                  text: "Registrieren",
                  onPressed: () => _navigateToAuth(context),
                  small: true,
                ),
              ],
            ),
          )
        ],
      ),

      // HAUPTINHALT (Scrollbar)
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentWidth),
            child: Column(
              children: [
                // --- SEKTION 1: HERO (Der Blickfang) ---
                _buildHeroSection(context, isDesktop),

                const SizedBox(height: 80),

                // --- SEKTION 2: INTRO (Warum Achtsamkeit?) ---
                _buildIntroSection(isDesktop),

                const SizedBox(height: 80),

                // --- SEKTION 3: FEATURES (Was kann die App?) ---
                _buildFeaturesSection(isDesktop),

                const SizedBox(height: 100),

                // --- SEKTION 4: FINAL CTA BANNER ---
                _buildFinalCTA(context),

                const SizedBox(height: 50),

                // FOOTER
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("© ${DateTime.now().year} aware. App. Alle Rechte vorbehalten.", style: TextStyle(color: Colors.grey[500])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SEKTION BUILDER METHODEN
  // -------------------------------------------------------------------------

  Widget _buildHeroSection(BuildContext context, bool isDesktop) {
    return SizedBox(
      height: isDesktop ? 600 : 500,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // HINTERGRUND DEKO (Aus dem Dashboard übernommen)
          Positioned(
            right: isDesktop ? -100 : -150,
            top: 50,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.play_arrow_rounded, size: 400, color: AppColors.tealPrimary),
            ),
          ),
          Positioned(
            left: isDesktop ? -50 : -100,
            bottom: 50,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.tealPrimary
              ),
            ),
          ),
          // Der markante orange Kreis
          Positioned(
            right: isDesktop ? 100 : 20,
            bottom: isDesktop ? 100 : 20,
            child: Container(
              width: 100, height: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.orangeStart, AppColors.orangeEnd],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))]
              ),
              child: const Icon(Icons.spa, color: Colors.white, size: 50),
            ),
          ),

          // VORDERGRUND TEXT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gestalte deine Zukunft.\nBewusst.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 56 : 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.tealDark,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "aware. ist dein täglicher Begleiter für Journaling,\nSelbstreflektion und mentales Wachstum.\nAlles an einem Ort.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: isDesktop ? 20 : 16,
                      color: Colors.grey[700],
                      height: 1.5
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _GradientButton(
                        text: "Jetzt starten",
                        onPressed: () => _navigateToAuth(context)
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                          side: const BorderSide(color: AppColors.tealPrimary, width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                      ),
                      onPressed: () => _navigateToAuth(context),
                      child: Text("Einloggen", style: TextStyle(color: AppColors.tealPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            "WARUM ACHTSAMKEIT?",
            style: TextStyle(color: AppColors.orangeEnd, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 15),
          Text(
            "Finde Ruhe im Chaos",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 32 : 26,
              fontWeight: FontWeight.bold,
              color: AppColors.tealDark,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 700,
            child: Text(
              "In einer Welt, die sich immer schneller dreht, verlieren wir oft den Kontakt zu uns selbst. 'aware.' hilft dir, täglich innezuhalten, deine Gedanken zu ordnen und eine tiefere Verbindung zu deinen Zielen und Gefühlen aufzubauen.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            "ALLE FUNKTIONEN",
            style: TextStyle(color: AppColors.tealPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 30),
          // Grid-ähnliches Layout mit Wrap für Responsivität
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: const [
              _FeatureCard(
                icon: Icons.grid_view,
                title: "Dein Dashboard",
                description: "Der zentrale Hub für deinen Fortschritt, tägliche Impulse und nächste Schritte.",
              ),
              _FeatureCard(
                icon: Icons.edit_note,
                title: "Multimedia Journal",
                description: "Halte Gedanken fest – mit Text, Formatierung oder Sprachnachrichten. ",
              ),
              _FeatureCard(
                icon: Icons.library_books,
                title: "Wissens-Bibliothek",
                description: "Kuratierte Artikel und Impulse zu Themen wie Dankbarkeit und Reflektion.",
              ),
              _FeatureCard(
                icon: Icons.self_improvement,
                title: "Geführte Übungen",
                description: "Meditationen und Atemübungen, um Stress abzubauen und Fokus zu finden.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalCTA(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        // Der orange-rote Verlauf als Hintergrund
          gradient: const LinearGradient(
            colors: [AppColors.orangeStart, AppColors.orangeEnd],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 20, offset: const Offset(0,10))]
      ),
      child: Column(
        children: [
          const Text(
            "Bereit für einen bewussteren Alltag?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            "Starte noch heute deine Reise zu mehr Klarheit und innerer Ruhe.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.orangeEnd,
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0
            ),
            onPressed: () => _navigateToAuth(context),
            child: const Text("Kostenlos registrieren", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}


// ---------------------------------------------------------------------------
// HELPER WIDGETS (Buttons & Karten)
// ---------------------------------------------------------------------------

// Der Feature-Karten-Stil aus dem Dashboard
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Feste Breite für konsistenten Look
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: AppColors.tealPrimary.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.tealPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Icon(icon, color: AppColors.tealPrimary, size: 30),
          ),
          const SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.tealDark)),
          const SizedBox(height: 10),
          Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5)),
        ],
      ),
    );
  }
}

// Der Haupt-Button mit dem orangen Verlauf
class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool small;

  const _GradientButton({required this.text, required this.onPressed, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.orangeStart, AppColors.orangeEnd],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: AppColors.orangeEnd.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: small ? 25 : 35, vertical: small ? 12 : 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: small ? 14 : 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}