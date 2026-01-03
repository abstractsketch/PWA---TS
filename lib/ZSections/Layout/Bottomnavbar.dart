import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';  

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        activeColor: Colors.grey[400],
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value) => onTabChange!(value),
        gap: 8,
        tabBorderRadius: 16,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Start',
          ),
          GButton(
            icon: Icons.book,
            text: 'Bibliothek',
          ),
          GButton(
            icon: Icons.add,
            text: 'Tagebuch',
          ),
          GButton(
            icon: Icons.mediation,
            text: 'Favoriten',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Einstellungen',
          ),
        ],
      ),
    );
  }
}