import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/1%20Login-Page/LandingPageR/Accountinfo.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Einstellungen"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            // Profilbild
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AccountInfo()),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Profil bearbeiten",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 30),

            //Kategorien
            _buildSectionTitle("Allgemein"),
            _buildSettingTile(Icons.language, "Sprache", "Deutsch"),
            _buildSettingTile(Icons.notifications, "Benachrichtigungen", "Aktiviert"),

            SizedBox(height: 20),

            _buildSectionTitle("Privatsphäre"),
            _buildSettingTile(Icons.lock, "Passwort ändern", ""),
            _buildSettingTile(Icons.shield, "Datenschutz", ""),

            SizedBox(height: 20),

            _buildSectionTitle("App"),
            _buildSettingTile(Icons.color_lens, "Design", "Hell"),
            _buildSettingTile(Icons.info_outline, "Über diese App", ""),
          ],
        ),
      ),
    );
  }

  /// --- Titel jeder Kategorie ---
  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  /// --- Einzelne Einstellung ---
  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[700]),
        title: Text(title, style: TextStyle(fontSize: 16)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: TextStyle(color: Colors.grey))
            : null,
        trailing: Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}

