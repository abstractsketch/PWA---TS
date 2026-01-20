import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Notizen/Notizen.dart';
import 'package:projekt_i/ZSections/Meditationen/Audio1.dart';
import 'package:projekt_i/ZSections/Meditationen/Video1.dart';
import 'package:projekt_i/ZSections/Bibliothek/Bibliothek.dart';
import 'package:projekt_i/ZSections/Layout/Bottomnavbar.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation1.dart';
import 'package:projekt_i/ZZaware/7%20Einstellungen/Settingspage.dart';
import 'package:projekt_i/ZSections/Layout/StartPage.dart';
import 'package:projekt_i/ZSections/Layout/responsive.dart';
import 'package:projekt_i/ZSections/Layout/top_app_bar.dart';
import 'package:projekt_i/ZSections/Notizen/Journalpage.dart';
import 'package:projekt_i/ZSections/Notizen/notizenwidget.dart';
import '../Layout/drawers.dart';
import '../../ZZaware/1 Login-Page/LandingPageR/auth.dart';

/*class Homepage2 extends StatefulWidget {
  static const String route = '/';

  @override
  State<Homepage2> createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {

  // -------------------- NEU: Bottom Navigation --------------------
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Seiten, die angezeigt werden sollen
  final List<Widget> pages = [
    const Meditation1(),
    const Bibliothek(),
    const Notizen(),
    const Meditationen(),
    const NotizenWidget(),
  ];
  // ---------------------------------------------------------------


  double _scrollPosition = 0;
  double _opacity = 0;

  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,


      // -------------------- NEU: Bottom Navigation Bar --------------------
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      // -------------------------------------------------------------------


      // AppBar bleibt wie gehabt (responsive)
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).cardColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Flutter Web',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopAppBar(_opacity),
            ),

      drawer: const Drawer(),

      // -------------------- NEU: Seitenumschaltung --------------------
      body: pages[selectedIndex],
      // ----------------------------------------------------------------
    );
  }
}
*/

//UI Home Page

//https://www.youtube.com/watch?v=qnk6NXEQFFI

class Homepage2 extends StatefulWidget {
  static const String route = '/';

  @override
  State<Homepage2> createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {

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

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
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