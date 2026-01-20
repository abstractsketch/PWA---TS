import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart';
import 'package:projekt_i/main.dart'; 

// -----------------------------------------------------------------------------
// 1. USER INFO SCREEN (Eingabe-Formular) - Modernisiert
// -----------------------------------------------------------------------------
class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _goalController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveDataAndContinue() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    
    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text) ?? 0,
        'meditation_goal': _goalController.text.trim(),
        'created_at': DateTime.now(),
        'email': user.email,
        'is_premium': false, // Standardwert
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResponsiveLayout()));
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const int myCurrentIndex = 2; 

    return  Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        centerTitle: true,
        title: Text("Profil einrichten", style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold)),
      ),
      body: 
      Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Willkommen!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.text)),
                SizedBox(height: 8),
                Text("Erzähl uns kurz etwas über dich, damit wir dein Erlebnis personalisieren können.", 
                  style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                SizedBox(height: 30),
                
                _buildModernField(_nameController, "Wie heißt du?", Icons.person_outline),
                SizedBox(height: 16),
                _buildModernField(_ageController, "Wie alt bist du?", Icons.cake_outlined, isNumber: true),
                SizedBox(height: 16),
                _buildModernField(_goalController, "Was ist dein Ziel? (z.B. weniger Stress)", Icons.flag_outlined),
                
                SizedBox(height: 40),
                
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tealDark,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: AppColors.tealDark.withOpacity(0.4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: _isLoading ? null : _saveDataAndContinue,
                    child: _isLoading 
                      ? CircularProgressIndicator(color: Colors.white) 
                      : Text("Los geht's", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }

  Widget _buildModernField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.tealDark),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. HELPER WIDGET: Einzelnes Feld anzeigen (ohne Boilerplate)
// -----------------------------------------------------------------------------
class FirestoreField extends StatelessWidget {
  final String collection;
  final String docId;
  final String field;
  final String fallback;
  final TextStyle? style;

  const FirestoreField({
    super.key,
    required this.collection,
    required this.docId,
    required this.field,
    this.fallback = "...",
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).doc(docId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text(fallback, style: style);
        }
        final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        return Text(data[field]?.toString() ?? fallback, style: style);
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EINSTELLUNGEN", style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2)),
              Text("Profil & Konto", style: TextStyle(color: AppColors.tealDark, fontWeight: FontWeight.bold, fontSize: 24)),
            ],
          ),
        ),
      ),
      body: user == null 
        ? Center(child: Text("Nicht eingeloggt")) 
        : StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            
            final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
            final username = data['username'] ?? "Benutzer";
            final email = data['email'] ?? user.email ?? "-";
            final age = data['age']?.toString() ?? "-";
            final goal = data['meditation_goal'] ?? "-";

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 1. Header Card (Dunkelblau)
                  _buildHeaderCard(username, email),
                  
                  SizedBox(height: 20),

                  // 2. Premium Banner (Orange)
                  _buildPremiumBanner(),

                  SizedBox(height: 30),

                  // 3. Sektion: Persönliche Daten
                  _buildSectionHeader("PERSÖNLICHE DATEN"),
                  _buildSettingsContainer([
                    _buildSettingsTile(Icons.cake_outlined, "Alter", value: "$age Jahre"),
                    _buildDivider(),
                    _buildSettingsTile(Icons.track_changes, "Fokus Ziel", value: goal),
                  ]),

                  SizedBox(height: 20),

                  // 4. Sektion: Allgemein
                  _buildSectionHeader("ALLGEMEIN"),
                  _buildSettingsContainer([
                    _buildSettingsTile(Icons.notifications_none_rounded, "Benachrichtigungen", isSwitch: true),
                    _buildDivider(),
                    _buildSettingsTile(Icons.dark_mode_outlined, "Dark Mode", isSwitch: true),
                    _buildDivider(),
                    _buildSettingsTile(Icons.language, "Sprache", value: "Deutsch"),
                  ]),

                  SizedBox(height: 20),

                  // 5. Sektion: Rechtliches
                  _buildSectionHeader("RECHTLICHES & SUPPORT"),
                  _buildSettingsContainer([
                    _buildSettingsTile(Icons.lock_outline, "Datenschutz", hasArrow: true),
                    _buildDivider(),
                    _buildSettingsTile(Icons.description_outlined, "Nutzungsbedingungen", hasArrow: true),
                    _buildDivider(),
                    _buildSettingsTile(Icons.mail_outline, "Kontakt aufnehmen", hasArrow: true),
                    _buildDivider(),
                    _buildSettingsTile(Icons.logout, "Ausloggen", onTap: () => FirebaseAuth.instance.signOut(), color: Colors.red),
                  ]),
                  
                  SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
    );
  }

  // --- WIDGET COMPONENTS FÜR PROFIL PAGE ---

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
                Text(name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(email, style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {}, // TODO: Edit Function
          )
        ],
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.orangeStart]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: AppColors.orangeStart, blurRadius: 15, offset: Offset(0, 8)),
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
                Text("Projekt I Premium", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Schalte alle Meditationen frei", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text("UPGRADE", style: TextStyle(color: AppColors.orangeStart, fontWeight: FontWeight.bold, fontSize: 10)),
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

  Widget _buildSettingsTile(IconData icon, String title, {String? value, bool isSwitch = false, bool hasArrow = false, VoidCallback? onTap, Color? color}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bgLight, shape: BoxShape.circle),
        child: Icon(icon, color: color ?? AppColors.tealPrimary, size: 20),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: color ?? AppColors.text)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) Text(value, style: TextStyle(color: Colors.grey, fontSize: 14)),
          if (isSwitch) 
            Switch(
              value: false, // Dummy Value
              onChanged: (val) {}, 
              activeColor: AppColors.tealDark,
            ),
          if (hasArrow || value != null) SizedBox(width: 8),
          if (hasArrow || (value != null && !isSwitch)) Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 0.5, color: Colors.grey[200], indent: 60, endIndent: 20);
  }
}

// -----------------------------------------------------------------------------
// 3. ENTRY DETAIL (Optional: Unverändert, nur Farben angepasst)
// -----------------------------------------------------------------------------
class EntryDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  EntryDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: AppColors.tealDark)),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['headline'] ?? "Ohne Titel", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.tealDark)),
            SizedBox(height: 8),
            Text(data['date_string'] ?? "", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Text(data['text'] ?? "", style: TextStyle(fontSize: 18, color: AppColors.text, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}