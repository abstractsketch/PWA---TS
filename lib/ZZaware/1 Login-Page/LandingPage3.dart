import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/LandingPage3D.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/LandingPage3S.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/LandingPage3T.dart';

class Landingpage3 extends StatelessWidget {
  const Landingpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 550) {
          return const LandingPage3S(); // Handy
        } else if (constraints.maxWidth < 900) {
          return const LandingPage3T(); // Tablet
        } else {
          return const LandingPage3D(); // Desktop
        }
      },
    );
  }
}