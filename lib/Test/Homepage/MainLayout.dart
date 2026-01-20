/*import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Audio/audiopage.dart';
import 'package:projekt_i/Test/Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Einstellungen.dart';
import 'package:projekt_i/Test/Homepage/HomepageR.dart';
import 'package:projekt_i/Test/Homepage/Homepage4.dart';
import 'package:projekt_i/Test/Journal/Journalpage.dart';
import 'package:projekt_i/Test/Journal/Journalentrypage.dart';
import 'package:projekt_i/Test/Journal/Kalendarpage.dart';
import 'package:projekt_i/Test/Journal/Testjournal.dart';
import 'package:projekt_i/Test/Journal/t%C3%A4gliche%20Frage.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  final Color kPrimaryGreen = const Color(0xFF608665);

  final List<Widget> _pages = [
    HomepageR(),
    Bibliothek2(), 
    Journalpage2(),
    Audiopage2(),
    Einstellungen2(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryGreen,
        unselectedItemColor: Colors.black26,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        elevation: 10, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Bibliothek'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Audio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/audiopage.dart' hide AppColors;
import 'package:projekt_i/ZZaware/4%20Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Einstellungen.dart';
import 'package:projekt_i/ZZaware/3%20Dashboard/HomepageR.dart' hide AppColors;
import 'package:projekt_i/ZZaware/5%20Journal/Journalpage.dart';
import 'package:projekt_i/main.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // Zentraler Inhalt je nach Index
  final List<Widget> _pages = [
    const Center(child: HomepageR()),
    const Center(child: Journalpage2()),
    const Center(child: Bibliothek2()),
    const Center(child: Audiopage2()),
    const Center(child: Einstellungen2()),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. SMARTPHONE LAYOUT (< 600px): BottomBar + AppBar mit Logo
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.remove_red_eye, color: AppColors.tealPrimary),
                  SizedBox(width: 8),
                  Text("aware.", style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              selectedItemColor: AppColors.tealPrimary,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Bibliothek'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Journal'),
                BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Audio'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Einstellungen'),
              ],
            ),
          );
        }

        // 2. TABLET LAYOUT (600px - 1000px): Drawer + AppBar
        if (constraints.maxWidth < 1000) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.tealPrimary),
              title: const Text("aware.", style: TextStyle(color: AppColors.orangeEnd)),
            ),
            drawer: Drawer(
              child: Sidebar(
                selectedIndex: _selectedIndex,
                onTap: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context);
                },
              ),
            ),
            body: _pages[_selectedIndex],
          );
        }

        // 3. DESKTOP LAYOUT (> 1000px): Feste Sidebar
        return Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: 260,
                child: Sidebar(
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: _pages[_selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

// --- GESTYLTE SIDEBAR ---
class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const Sidebar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Icon(Icons.remove_red_eye, size: 50, color: AppColors.tealPrimary),
          const SizedBox(height: 10),
          const Text("aware.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.tealDark)),
          const SizedBox(height: 50),
          
          _SidebarItem(
            icon: Icons.grid_view, 
            text: "Home", 
            isActive: selectedIndex == 0, 
            onTap: () => onTap(0)
          ),
          _SidebarItem(
            icon: Icons.edit_note, 
            text: "Journal", 
            isActive: selectedIndex == 1, 
            onTap: () => onTap(1)
          ),
          _SidebarItem(
            icon: Icons.library_books, 
            text: "Bibliothek", 
            isActive: selectedIndex == 2, 
            onTap: () => onTap(2)
          ),
          _SidebarItem(
            icon: Icons.self_improvement, 
            text: "Übungen", 
            isActive: selectedIndex == 3, 
            onTap: () => onTap(3)
          ),
          _SidebarItem(
            icon: Icons.settings, 
            text: "Einstellungen", 
            isActive: selectedIndex == 4, 
            onTap: () => onTap(4)
          ),
          
          const Spacer(),
          _SidebarItem(icon: Icons.person_outline, text: "Account", onTap: () {}),
          _SidebarItem(icon: Icons.logout, text: "Logout", onTap: () {}),
        ],
      ),
    );
  }
}

// --- GESTYLTES SIDEBAR ITEM ---
class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon, 
    required this.text, 
    required this.onTap, 
    this.isActive = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.tealPrimary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: isActive ? AppColors.tealPrimary : Colors.grey),
          title: Text(
            text,
            style: TextStyle(
              color: isActive ? AppColors.tealPrimary : Colors.grey[700],
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}