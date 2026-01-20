import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart' hide AppColors;
import 'package:projekt_i/main.dart';
// ---------------------------------------------------------------------------
// 2. MAIN LANDING PAGE
// ---------------------------------------------------------------------------

class DesktopLandingPage extends StatelessWidget {
  const DesktopLandingPage({super.key});

  void _navigateToAuth(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Da es eine Desktop-Page ist, gehen wir von breiten Bildschirmen aus.
    // Wir nutzen ConstrainedBox, um den Inhalt mittig zu halten (max 1200px).
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. NAVBAR ---
            _buildNavbar(context),

            // --- 2. HERO SECTION ---
            _buildHeroSection(context),

            // --- 3. STATS / TRUST ---
            _buildStatsSection(),

            // --- 4. FEATURE GRID ---
            _buildFeaturesSection(),

            // --- 5. CONTENT SECTION (Journaling) ---
            _buildContentSectionImgRight(),

            // --- 6. CTA BANNER ---
            _buildBottomCTA(context),

            // --- 7. FOOTER ---
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTIONS
  // ---------------------------------------------------------------------------

  Widget _buildNavbar(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              // LOGO
              const Icon(Icons.spa, color: AppColors.tealPrimary, size: 30),
              const SizedBox(width: 10),
              const Text("aware.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.tealDark)),
              
              const Spacer(),

              // MENU LINKS (Desktop typisch)
              _NavbarLink(title: "Funktionen"),
              const SizedBox(width: 30),
              _NavbarLink(title: "Über uns"),
              const SizedBox(width: 30),
              _NavbarLink(title: "Preise"),

              const Spacer(),

              // AUTH BUTTONS
              TextButton(
                onPressed: () => _navigateToAuth(context),
                child: const Text("Login", style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15)
                ),
                onPressed: () => _navigateToAuth(context),
                child: const Text("Registrieren"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bgLight, // Leichter Kontrast zur weißen Navbar
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              // LINKER TEXT
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.orangeStart.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: const Text("Neu: Version 2.0 ist da", style: TextStyle(color: AppColors.orangeEnd, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Der Ort für deine\ninneren Gedanken.",
                      style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Colors.black, height: 1.1),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "aware. verbindet Journaling, Achtsamkeit und Weiterbildung in einer einzigen, wunderschönen Desktop-App.",
                      style: TextStyle(fontSize: 18, color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        _GradientCtaButton(label: "Kostenlos starten", onTap: () => _navigateToAuth(context)),
                        const SizedBox(width: 20),
                        TextButton.icon(
                          onPressed: (){}, 
                          icon: const Icon(Icons.play_circle_fill, color: AppColors.tealPrimary),
                          label: const Text("Demo ansehen", style: TextStyle(color: Colors.black))
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: const [
                        Icon(Icons.check_circle, size: 16, color: AppColors.tealPrimary), SizedBox(width: 5),
                        Text("Keine Kreditkarte nötig", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(width: 20),
                        Icon(Icons.check_circle, size: 16, color: AppColors.tealPrimary), SizedBox(width: 5),
                        Text("Datenschutz garantiert", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 50),
              // RECHTES MOCKUP (Abstraktes UI Bild)
              Expanded(
                flex: 6,
                child: _buildAppMockup(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _StatItem(number: "10k+", label: "Aktive Nutzer"),
            _StatItem(number: "500+", label: "Artikel & Übungen"),
            _StatItem(number: "4.9", label: "App Store Rating"),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const Text("DEINE WERKZEUGE", style: TextStyle(color: AppColors.tealPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const SizedBox(height: 10),
              const Text("Alles was du brauchst.", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 60),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: _FeatureCard(icon: Icons.edit_note, title: "Smart Journal", desc: "Ein intelligenter Editor für deine täglichen Gedanken, mit Tags und Formatierung.")),
                  SizedBox(width: 30),
                  Expanded(child: _FeatureCard(icon: Icons.menu_book, title: "Bibliothek", desc: "Hunderte Artikel über Psychologie, Philosophie und Selbsthilfe.")),
                  SizedBox(width: 30),
                  Expanded(child: _FeatureCard(icon: Icons.self_improvement, title: "Meditation", desc: "Geführte Audio-Sessions und Timer für deine tägliche Ruhepause.")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSectionImgRight() {
    return Container(
      width: double.infinity,
      color: AppColors.bgLight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              // TEXT
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      child: const Icon(Icons.favorite, color: AppColors.orangeEnd),
                    ),
                    const SizedBox(height: 20),
                    const Text("Lerne dich selbst kennen.", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 20),
                    const Text(
                      "Oft verstehen wir unsere Gefühle erst, wenn wir sie aufschreiben. 'aware.' bietet dir Journaling Prompts, die dich zum Nachdenken anregen und dir helfen, Muster in deinem Verhalten zu erkennen.",
                      style: TextStyle(fontSize: 18, color: Colors.grey, height: 1.6),
                    ),
                    const SizedBox(height: 30),
                    const Text("• Tägliche Fragen", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tealDark)),
                    const SizedBox(height: 10),
                    const Text("• Stimmungstracker", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tealDark)),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              // IMAGE (Platzhalter Box)
              Expanded(
                flex: 1,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))]
                  ),
                  child: Center(
                    child: Icon(Icons.edit, size: 100, color: AppColors.bgLight),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.tealPrimary, AppColors.tealDark], begin: Alignment.topLeft, end: Alignment.bottomRight)
      ),
      child: Column(
        children: [
          const Text("Bereit für mehr Achtsamkeit?", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text("Werde Teil der Community und starte deine Reise.", style: TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.tealDark,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            ),
            onPressed: () => _navigateToAuth(context),
            child: const Text("Kostenlos registrieren", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("aware.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 10),
                  Text("Made with ❤️ for Mindfulness.", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const Spacer(),
              _FooterColumn(title: "Produkt", links: const ["Funktionen", "Preise", "Updates"]),
              const SizedBox(width: 50),
              _FooterColumn(title: "Unternehmen", links: const ["Über uns", "Karriere", "Kontakt"]),
              const SizedBox(width: 50),
              _FooterColumn(title: "Rechtliches", links: const ["Impressum", "Datenschutz", "AGB"]),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------------------------------

  // Baut ein visuelles "App Fenster" als Mockup
  Widget _buildAppMockup() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.tealPrimary.withOpacity(0.15), blurRadius: 40, offset: const Offset(0, 20))
        ]
      ),
      child: Column(
        children: [
          // Mockup Header (Fensterleiste)
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Colors.grey[300]!))
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                CircleAvatar(backgroundColor: Colors.red[200], radius: 4), const SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.amber[200], radius: 4), const SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.green[200], radius: 4),
              ],
            ),
          ),
          // Mockup Inhalt (Abstraktes Dashboard)
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(width: 60, color: AppColors.tealDark.withOpacity(0.1)),
                // Main Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 150, height: 20, color: Colors.grey[200]), // Title
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Container(height: 100, decoration: BoxDecoration(color: AppColors.orangeStart.withOpacity(0.1), borderRadius: BorderRadius.circular(10)))),
                            const SizedBox(width: 15),
                            Expanded(child: Container(height: 100, decoration: BoxDecoration(color: AppColors.tealPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)))),
                          ],
                        ),
                         const SizedBox(height: 20),
                         Container(width: double.infinity, height: 100, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NavbarLink extends StatelessWidget {
  final String title;
  const _NavbarLink({required this.title});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 16)),
    );
  }
}

class _GradientCtaButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GradientCtaButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.tealDark)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _FeatureCard({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.tealPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppColors.tealPrimary, size: 30),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(fontSize: 15, color: Colors.grey, height: 1.5)),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 15),
        ...links.map((l) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(l, style: const TextStyle(color: Colors.grey)),
        ))
      ],
    );
  }
}