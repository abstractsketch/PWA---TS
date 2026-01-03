import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Audio/audiopage.dart';
import 'package:projekt_i/Test/Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Einstellungen.dart';
import 'package:projekt_i/Test/Homepage/Homepage3.dart';
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
    Homepage3(),
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