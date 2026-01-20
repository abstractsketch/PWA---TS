import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
import 'package:projekt_i/main.dart';

// Stelle sicher, dass du deine Imports für AppColors und ResponsiveLayout/Wrapper hast.

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  // --- LOGIK (Unverändert) ---
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

  Future<void> _updateAccountData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text) ?? 0,
        'meditation_goal': _goalController.text.trim(),
        'bio': _bioController.text.trim(),      
        'location': _locationController.text.trim(), 
        'last_updated': DateTime.now(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profil erfolgreich aktualisiert!"),
          backgroundColor: AppColors.tealDark,
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Speichern.")),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // --- UI BUILD ---
  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 4; 

    return ResponsiveWrapper(
      selectedIndex: myCurrentIndex,
      onTabChange: (clickedIndex) {
        if (clickedIndex == myCurrentIndex) return;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ResponsiveLayout(initialIndex: clickedIndex),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.bgLight,
        // AppBar im neuen Stil
        
        body: Center(
          child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1400),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            "EINSTELLUNGEN",
                            style: const TextStyle(
                              color: AppColors.tealPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            'Profil & Konto',
                            style: TextStyle(
                                    color: AppColors.tealDark,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    height: 1.1),
                          ),
                          const SizedBox(height: 25),
                          // 1. Header Card (Dunkelblau) mit User-Daten
                          _buildHeaderCard(_nameController.text, _email),
                          
                          SizedBox(height: 20),
          
                          // 2. Premium Banner (Orange)
                          _buildPremiumBanner(),
          
                          SizedBox(height: 30),
          
                          // 3. Sektion: Persönliche Daten (IN WEISSER KARTE)
                          _buildSectionHeader("PERSÖNLICHE DATEN BEARBEITEN"),
                          _buildSettingsContainer([
                             SizedBox(height: 10),
                            _buildInputTile(_nameController, "Benutzername", Icons.person_outline),
                            _buildDivider(),
                            Row(
                              children: [
                                Expanded(child: _buildInputTile(_ageController, "Alter", Icons.cake_outlined, isNumber: true)),
                                Container(width: 1, height: 40, color: Colors.grey[200]), // Vertikaler Trenner
                                Expanded(child: _buildInputTile(_locationController, "Ort", Icons.location_on_outlined)),
                              ],
                            ),
                            _buildDivider(),
                            _buildInputTile(_goalController, "Fokus Ziel", Icons.flag_outlined),
                            _buildDivider(),
                            _buildInputTile(_bioController, "Über mich", Icons.info_outline, maxLines: 3),
                            SizedBox(height: 10),
                          ]),
          
                          SizedBox(height: 20),
          
                          // 4. Sektion: Account Details (IN WEISSER KARTE)
                          _buildSectionHeader("ACCOUNT DETAILS"),
                          _buildSettingsContainer([
                            _buildInfoTile(Icons.calendar_today, "Dabei seit", _memberSince),
                            _buildDivider(),
                            _buildActionTile(Icons.security, "Passwort ändern", () {
                               // Passwort Logik hier
                            }),
                          ]),
          
                          SizedBox(height: 40),
          
                          // 5. Speichern Button
                           SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.tealDark,
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  shadowColor: AppColors.tealDark.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              onPressed: _isSaving ? null : _updateAccountData,
                              child: _isSaving 
                                ? CircularProgressIndicator(color: Colors.white) 
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save_outlined),
                                      SizedBox(width: 10),
                                      Text("Änderungen speichern", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS IM NEUEN DESIGN ---

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

  Widget _buildPremiumBanner() {
    // Falls AppColors.orangeStart nicht definiert ist, nutze Colors.orange
    Color orangeColor = Colors.orange; 
    try { orangeColor = AppColors.orangeStart; } catch(e) {}

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [orangeColor, orangeColor.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: orangeColor.withOpacity(0.4), blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(Icons.star, color: Colors.white, size: 24),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kostenlose Version", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(_isPremium ? "Aktiviert" : "Schalte alle Inhalte frei", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
              ],
            ),
          ),
          if (!_isPremium)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Text("UPGRADE", style: TextStyle(color: orangeColor, fontWeight: FontWeight.bold, fontSize: 10)),
            )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1),
      ),
    );
  }

  Widget _buildSettingsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 0.5, color: Colors.grey[200], indent: 60, endIndent: 20);
  }

  // Eingabefeld integriert in das weiße Kartendesign
  Widget _buildInputTile(TextEditingController controller, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.text),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: AppColors.tealPrimary, size: 22),
          border: InputBorder.none, // Kein Rahmen, damit es sauber in der Karte aussieht
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          isDense: true,
        ),
      ),
    );
  }

  // Info Tile (Read only)
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bgLight, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.tealPrimary, size: 20),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.text)),
      trailing: Text(value, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  // Action Tile (Buttons wie Passwort ändern oder Logout)
  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: isDestructive ? Colors.red.withOpacity(0.1) : AppColors.bgLight, shape: BoxShape.circle),
        child: Icon(icon, color: isDestructive ? Colors.red : AppColors.tealPrimary, size: 20),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: isDestructive ? Colors.red : AppColors.text)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
    );
  }
}