import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/Accountinfo.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/auth.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/AuthScreen.dart'; // Beinhaltet AuthScreen
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart'; // Falls nötig
import 'package:projekt_i/main.dart'; // Beinhaltet AppColors

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onTabChange;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ----------------------------------------------------------
        // 1. SMARTPHONE LAYOUT (< 600px): BottomBar + Styled AppBar
        // ----------------------------------------------------------
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.tealPrimary,
              elevation: 0,
              centerTitle: true,
              title: _buildLogoWithIcon(), // Logo + Icon
            ),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.bgLight,
              currentIndex: selectedIndex,
              onTap: onTabChange,
              selectedItemColor: AppColors.orangeEnd, // UI Update: Orange statt TealDark
              unselectedItemColor: AppColors.tealPrimary,
              type: BottomNavigationBarType.fixed,
              // UI Update: Icons aus dem Originalcode
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bib"),
                BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Journal"),
                BottomNavigationBarItem(icon: Icon(Icons.audiotrack), label: "Audio"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Einstellungen"),
              ],
            ),
          );
        }

        // ----------------------------------------------------------
        // 2. TABLET LAYOUT (600px - 900px): Drawer + Styled AppBar
        // ----------------------------------------------------------
        if (constraints.maxWidth < 900) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true, // Drawer Icon
              backgroundColor: AppColors.tealPrimary,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: AppColors.cardWhite),
              title: _buildLogoShaderOnly(), // Nur Text Logo
            ),
            drawer: Drawer(
              child: Sidebar(
                selectedIndex: selectedIndex,
                onTap: (index) {
                  Navigator.pop(context); // Drawer schließen
                  onTabChange(index);
                },
              ),
            ),
            body: child,
          );
        }

        // ----------------------------------------------------------
        // 3. DESKTOP LAYOUT (> 900px): Feste Sidebar + Styled AppBar
        // ----------------------------------------------------------
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            titleSpacing: 20,
            backgroundColor: AppColors.tealPrimary,
            elevation: 0,
            // UI Update: Icon links außen, Text mittig (wie im Desktop Layout Vorlage)
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0), // Angepasst damit es nicht zu weit weg ist
              child: const Icon(Icons.remove_red_eye, color: AppColors.cardWhite),
            ),
            leadingWidth: 60, 
            title: _buildLogoShaderOnly(),
          ),
          body: Row(
            children: [
              SizedBox(
                width: 260,
                child: Sidebar(
                  selectedIndex: selectedIndex,
                  onTap: onTabChange,
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Widgets für das UI Design ---

  Widget _buildLogoShaderOnly() {
    return ShaderMask(
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
    );
  }

  Widget _buildLogoWithIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.remove_red_eye, color: AppColors.cardWhite),
        const SizedBox(width: 8),
        ShaderMask(
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
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// HIER SIND DIE GESTYLTEN SIDEBAR KLASSEN AUS DEINEM CODE
// ---------------------------------------------------------------------------

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
          const SizedBox(height: 10),
          
          _SidebarItem(
            icon: Icons.grid_view, 
            text: "Home", 
            isActive: widget.selectedIndex == 0, 
            onTap: () => widget.onTap(0)
          ),
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
            isActive: _isProcessing,
            onTap: _isProcessing
              ? () {}
              : () async{
                setState(() { _isProcessing = true; }); // Loading state setzen
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
                if(mounted) {
                  setState(() { _isProcessing = false; });
                }
              },
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