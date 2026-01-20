import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Bibliothek/Bibliothek.dart';
import 'package:projekt_i/ZSections/Layout/Bottomnavbar.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen.dart';
import 'package:projekt_i/ZZaware/7%20Einstellungen/Settingspage.dart';
import 'package:projekt_i/ZSections/Layout/StartPage.dart';
import 'package:projekt_i/ZSections/Layout/drawers.dart';
import 'package:projekt_i/ZSections/Notizen/Journalpage.dart';

//UI Home Page

//https://www.youtube.com/watch?v=qnk6NXEQFFI

class Homepage extends StatefulWidget {
  static const String route = '/';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Seiten, die angezeigt werden sollen
  final List<Widget> pages = [
    const StartPage(),
    const Bibliothek(),
    JournalPage(),
    Meditationen(),
    SettingsPage(),
    //const NotizenWidget(),
  ];
  
  double _scrollPosition = 0;
  double _opacity = 0;

  //Define variables of grid items
  final List<Map> myProducts = List.generate(100000, (index) => {"id": index, "name": "Product $index"}).toList();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
    ? _scrollPosition / (screenSize.height * 0.40)
    : 1;

    //changes in two places for integrating the AuthDialog in top bar (wide screen) small bar (small)
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Simpicity"),
        elevation: 0,
      

        actions: [
          IconButton(
            icon: const Icon(
              Icons.person, 
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(), // <-- deine Zielseite
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),


      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      
      /*//call of responsive
      appBar: ResponsiveWidget.isSmallScreen(context)
      ?AppBar(
        backgroundColor: Theme.of(context).cardColor.withOpacity(_opacity),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'mind',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          )
        )
      )
      :PreferredSize(  
        preferredSize: Size(screenSize.width, 1000),

        child: TopAppBar(_opacity),
      ),*/

      drawer: Drawers(),
      body: pages[selectedIndex],
      
    );

  }
}