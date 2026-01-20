import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/Accountinfo.dart';
import 'package:projekt_i/main.dart';

class Einstellungen2 extends StatefulWidget {
  const Einstellungen2({super.key});

  @override
  State<Einstellungen2> createState() => _Einstellungen2State();
}

class _Einstellungen2State extends State<Einstellungen2> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _goalController = TextEditingController();
  final _bioController = TextEditingController(); 
  final _locationController = TextEditingController(); 

  String _email = "";
  String _memberSince = "";
  bool _isPremium = false;

  bool _isLoading = true; 
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        setState(() {
          _nameController.text = data['username'] ?? '';
          _ageController.text = (data['age'] ?? '').toString();
          _goalController.text = data['meditation_goal'] ?? '';
          _bioController.text = data['bio'] ?? ''; 
          _locationController.text = data['location'] ?? ''; 
          
          _email = user.email ?? '';
          _isPremium = data['is_premium'] ?? false;
          
          if (data['created_at'] != null) {
            DateTime date = (data['created_at'] as Timestamp).toDate();
            _memberSince = "${date.day}.${date.month}.${date.year}";
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Fehler beim Laden: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "EINSTELLUNGEN",
                    style: TextStyle(
                      color: AppColors.tealPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Profil & Konto',
                    style: TextStyle(
                      color: AppColors.tealDark, 
                      fontSize: 32, 
                      fontWeight: FontWeight.bold, 
                      height: 1.1
                    ),
                  ),
                  const SizedBox(height: 30),
            
                  _buildHeaderCard(_nameController.text, _email),

                  const SizedBox(height: 24),
            
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.orangeStart, AppColors.orangeEnd]),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 30),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("aware. Premium", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 2),
                              Text("Schalte alle Meditationen und Atemübungen frei", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: const Text("UPGRADE", style: TextStyle(color: AppColors.orangeEnd, fontWeight: FontWeight.bold, fontSize: 10)),
                        )
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 30),
            
                  _buildSectionHeader("Allgemein"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          icon: Icons.notifications_outlined, 
                          title: "Benachrichtigungen", 
                          value: _notificationsEnabled,
                          onChanged: (val) => setState(() => _notificationsEnabled = val),
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          icon: Icons.dark_mode_outlined, 
                          title: "Dark Mode", 
                          value: _darkModeEnabled,
                          onChanged: (val) => setState(() => _darkModeEnabled = val),
                        ),
                        _buildDivider(),
                        _buildNavTile(Icons.language, "Sprache", "Deutsch"),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 24),
            
                  _buildSectionHeader("Rechtliches & Support"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        _buildNavTile(Icons.lock_outline, "Datenschutz", ""),
                        _buildDivider(),
                        _buildNavTile(Icons.description_outlined, "Nutzungsbedingungen", ""),
                        _buildDivider(),
                        _buildNavTile(Icons.mail_outline, "Kontakt aufnehmen", ""),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 40),
            
                  // 5. LOGOUT BUTTON (Schlicht, aber erkennbar)
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: AppColors.orangeEnd),
                      label: const Text("Abmelden", style: TextStyle(color: AppColors.orangeEnd, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  const Center(child: Text("Version 1.0.2", style: TextStyle(color: Colors.grey, fontSize: 10))),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(String name, String email) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.tealDark,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: AppColors.tealDark.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Text(name.isNotEmpty ? name[0].toUpperCase() : "U", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.isEmpty ? "Benutzer" : name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(email, style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          // Edit Icon hier entfernt, da wir unten bearbeiten
        ],
      ),
    );
  }



  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1), indent: 60, endIndent: 20);
  }

  // Ein Tile mit Switch (An/Aus)
  Widget _buildSwitchTile({required IconData icon, required String title, required bool value, required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.tealPrimary, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title, 
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.tealDark, fontSize: 15)
            ),
          ),
          Switch(
            value: value, 
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.tealPrimary,
          )
        ],
      ),
    );
  }

  // Ein Tile mit Pfeil (Navigation)
  Widget _buildNavTile(IconData icon, String title, String trailing) {
    return InkWell( // InkWell für Klick-Effekt
      onTap: () {},
      borderRadius: BorderRadius.circular(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.tealPrimary, size: 22),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title, 
                style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.tealDark, fontSize: 15)
              ),
            ),
            if (trailing.isNotEmpty)
              Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
            if (trailing.isNotEmpty) const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:projekt_i/Test/Homepage/Test.dart';

class Einstellungen2 extends StatelessWidget {

  const Einstellungen2({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Einstellungen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),

          _buildSectionHeader(context, "Account"),
          _buildSettingsCard(
            context,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                title: const Text("Persönliche Daten"),
                subtitle: const Text("Name, E-Mail, Passwort"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()),
                  );
                },
              ),
              const Divider(height: 1, indent: 56),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text("Sicherheit & Login"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildSectionHeader(context, "Allgemein"),
          _buildSettingsCard(
            context,
            children: [
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text("Benachrichtigungen"),
                trailing: Switch.adaptive(
                  value: true, 
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (val) {},
                ),
              ),
              const Divider(height: 1, indent: 56),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Sprache"),
                subtitle: const Text("Deutsch"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
*/