import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:projekt_i/ZSections/Homepage/HomePage2.dart';
import 'package:projekt_i/ZSections/Layout/StartPage.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/Accountinfo.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart' hide AppColors;
import 'package:projekt_i/ZZaware/1%20Login-Page/Userscreen.dart' hide AppColors;
import 'package:projekt_i/ZZaware/6%20Uebungen/alteaudiopages.dart';
import 'package:projekt_i/main.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/audiopage.dart' hide AppColors;
import 'package:projekt_i/ZZaware/4%20Bibliothek/Bibliothek2.dart';
import 'package:projekt_i/Test/Einstellungen.dart';
import 'package:projekt_i/ZZaware/3%20Dashboard/HomepageR.dart' hide AppColors;
import 'package:projekt_i/ZZaware/5%20Journal/Journalpage.dart';

class ResponsiveLayout extends StatefulWidget {
  final int initialIndex; 

  const ResponsiveLayout({
    super.key, 
    this.initialIndex = 0 
  });

  @override
  State<ResponsiveLayout> createState() => ResponsiveLayoutState();
}


class ResponsiveLayoutState extends State<ResponsiveLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // HIER übernehmen wir den gewünschten Start-Index
    _selectedIndex = widget.initialIndex;
  }

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
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.tealPrimary,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_red_eye, color: AppColors.bgLight),
                  SizedBox(width: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.orangeStart, AppColors.orangeEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "aware.",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 24, // Größe nach Bedarf anpassen
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )               
                ],
              ),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.bgLight,
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              selectedItemColor: AppColors.orangeStart,
              unselectedItemColor: AppColors.tealPrimary,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: "Bib"),
                BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Journal"),
                BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: "Audio"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Einstellungen"),
              ],
            ),
          );
        }

        // 2. TABLET LAYOUT (600px - 1000px): Drawer + AppBar
        if (constraints.maxWidth < 900) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: AppColors.tealPrimary,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: AppColors.cardWhite),
              title: ShaderMask( 
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColors.orangeStart, AppColors.orangeEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  "aware.",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) 
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
          appBar: AppBar(

            centerTitle: true, 
            
            titleSpacing: 20, 

            automaticallyImplyLeading: false, 
            
            leading: Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: const Icon(Icons.remove_red_eye, color: AppColors.cardWhite),
            ),
            
            backgroundColor: AppColors.tealPrimary,
            elevation: 0,
            
            title: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.orangeStart, AppColors.orangeEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "aware.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const Sidebar({super.key, required this.selectedIndex, required this.onTap});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tealPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          /*ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.orangeStart, AppColors.orangeEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              "aware.",
              style: TextStyle(
                // Die Farbe hier ist egal, solange sie NICHT transparent ist.
                // Weiß ist am sichersten.
                color: Colors.white, 
                fontSize: 24, // Größe nach Bedarf anpassen
                fontWeight: FontWeight.bold,
              ),
            ),
          ),*/
          const SizedBox(height: 10),
          
          _SidebarItem(
            icon: Icons.home, 
            text: "Home", 
            isActive: widget.selectedIndex == 0, 
            onTap: () => widget.onTap(0)          ),
          _SidebarItem(
            icon: Icons.edit_note, 
            text: "Journal", 
            isActive: widget.selectedIndex == 1, 
            onTap: () => widget.onTap(1)
          ),
          _SidebarItem(
            icon: Icons.library_books, 
            text: "Bibliothek", 
            isActive: widget.selectedIndex == 2, 
            onTap: () => widget.onTap(2)
          ),
          _SidebarItem(
            icon: Icons.self_improvement, 
            text: "Übungen", 
            isActive: widget.selectedIndex == 3, 
            onTap: () => widget.onTap(3)
          ),
          _SidebarItem(
            icon: Icons.settings, 
            text: "Einstellungen", 
            isActive: widget.selectedIndex == 4, 
            onTap: () => widget.onTap(4)
          ),
          
          const Spacer(),
          _SidebarItem(
            icon: Icons.person_outline, 
            text: "Account", 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfo())),
          ),
          _SidebarItem(
            icon: Icons.logout, 
            text: "Logout", 
            onTap: _isProcessing
              ? () {}
              : () async{
                await signOut().then((result) {
                  print(result);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder:(context) => AuthScreen(),
                    ),
                  );
                }).catchError((error) {
                print('SignOut Error: $error');
                });
                setState(() {
                  _isProcessing = false;
                });
              },
              isActive: _isProcessing,
          ),
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
          color: isActive ? AppColors.cardWhite : AppColors.tealPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: isActive ? AppColors.orangeEnd : AppColors.cardWhite),
          title: Text(
            text,
            style: TextStyle(
              color: isActive ? AppColors.orangeEnd : AppColors.cardWhite,
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
