import 'package:flutter/material.dart';
import 'package:projekt_i/zzaware/6%20Uebungen/BreathofFire.dart';
import 'package:projekt_i/main.dart'; 

class BofInfo extends StatelessWidget {
  const BofInfo({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Die magische Achse links
            children: [
              // Zurück-Button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.tealPrimary, size: 20),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 30),

              // Titel & Header
              const Text(
                "Breath of Fire",
                style: TextStyle(
                  fontSize: 34, 
                  fontWeight: FontWeight.w900, 
                  color: AppColors.text,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.orangeStart,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 30),

              // Einleitungstext
              const Text(
                "Kapalabhati, auch bekannt als der Feueratem, ist eine energetisierende Reinigungstechnik. Sie hilft dir, in kürzester Zeit einen wachen Geist und einen klaren Fokus zu erlangen.",
                style: TextStyle(
                  fontSize: 17, 
                  color: Colors.black87, 
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left, // Expliziter Flattersatz
              ),

              const SizedBox(height: 40),

              // Sektion: Die Wirkung
              _buildSectionHeader("DIE WIRKUNG"),
              const Text(
                "Durch die schnelle Sauerstoffzufuhr wird dein Nervensystem stimuliert. Es wirkt wie ein natürlicher Espresso: Dein Kreislauf kommt in Schwung, die Verdauung wird angeregt und mentale Müdigkeit verfliegt.",
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                textAlign: TextAlign.left,
              ),

              const SizedBox(height: 40),

              // Sektion: Anleitung
              _buildSectionHeader("SCHRITT FÜR SCHRITT"),
              _buildStepRow("01", "Haltung", "Setze dich aufrecht hin. Deine Wirbelsäule ist gestreckt, dein Brustkorb weit."),
              _buildStepRow("02", "Ausatmung", "Stoße die Luft ruckartig durch die Nase aus. Ziehe den Bauchnabel dabei nach innen."),
              _buildStepRow("03", "Einatmung", "Lass den Bauch locker. Die Einatmung geschieht völlig automatisch und passiv."),
              _buildStepRow("04", "Frequenz", "Beginne mit einem Stoß pro Sekunde. Halte den Rhythmus stabil und ruhig."),

              const SizedBox(height: 30),

              // Sicherheitshinweis-Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border(left: BorderSide(color: Colors.redAccent.shade100, width: 5)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shield_outlined, color: Colors.redAccent.shade200, size: 20),
                        const SizedBox(width: 8),
                        const Text("SICHERHEIT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Nicht geeignet bei Schwangerschaft, Bluthochdruck oder Epilepsie. Bei Schwindel sofort pausieren.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // CTA Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.text,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Breathoffire()));
                  },
                  child: const Text(
                    "ÜBUNG STARTEN",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Hilfs-Widget für Sektions-Überschriften
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13, 
          fontWeight: FontWeight.w800, 
          color: AppColors.tealPrimary.withOpacity(0.8), 
          letterSpacing: 2,
        ),
      ),
    );
  }

  // Hilfs-Widget für die Schritte (Horizontal-Layout)
  Widget _buildStepRow(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w900, 
              color: AppColors.orangeStart.withOpacity(0.3),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}