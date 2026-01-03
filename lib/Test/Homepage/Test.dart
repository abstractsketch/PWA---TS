import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt_i/Test/Homepage/MainLayout.dart';

const Color kBackgroundColor = Colors.white; 
const Color kPrimaryGreen = Color(0xFF608665);
const Color kCardColor = Color(0xFFF9F9F9);
const Color kTextDark = Color(0xFF2E3D31);

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;

  Future<void> _submitAuth() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainLayout()));
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserInfoScreen()));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? "Willkommen zurück" : "Konto erstellen",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kPrimaryGreen),
                ),
                SizedBox(height: 40),
                _buildTextField(_emailController, "Email Adresse", false),
                SizedBox(height: 16),
                _buildTextField(_passwordController, "Passwort", true),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _submitAuth,
                  child: Text(isLogin ? "Einloggen" : "Registrieren", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => setState(() => isLogin = !isLogin),
                  child: Text(
                    isLogin ? "Noch kein Konto? Registrieren" : "Bereits ein Konto? Einloggen",
                    style: TextStyle(color: kPrimaryGreen),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: kTextDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: kCardColor,
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryGreen.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryGreen.withOpacity(0.1)),
        ),
      ),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _goalController = TextEditingController();

  Future<void> _saveDataAndContinue() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text) ?? 0,
        'meditation_goal': _goalController.text.trim(),
        'created_at': DateTime.now(),
        'email': user.email,
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainLayout()));
    } catch (e) { print(e); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Dein Profil einrichten", style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text("Erzähl uns etwas über dich", style: TextStyle(color: kTextDark, fontSize: 18)),
            SizedBox(height: 20),
            _buildInfoField(_nameController, "Dein Name"),
            SizedBox(height: 12),
            _buildInfoField(_ageController, "Dein Alter", isNumber: true),
            SizedBox(height: 12),
            _buildInfoField(_goalController, "Dein Ziel (z.B. Entspannung)"),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: _saveDataAndContinue,
              child: Text("Speichern & Starten", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(TextEditingController controller, String hint, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: kCardColor,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: kPrimaryGreen.withOpacity(0.1))),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(title: Text("Profil", style: TextStyle(color: kPrimaryGreen)), backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: kPrimaryGreen)),
      body: user == null ? Center(child: Text("Kein User")) : StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null) return Center(child: Text("Keine Daten"));
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildProfileItem("Name", data['username'], Icons.person),
                _buildProfileItem("Alter", "${data['age']} Jahre", Icons.cake),
                _buildProfileItem("Ziel", data['meditation_goal'], Icons.star),
                _buildProfileItem("Email", data['email'], Icons.email),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileItem(String title, String? val, IconData icon) {
    return Card(
      color: kCardColor,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: kPrimaryGreen),
        title: Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(val ?? "-", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryGreen)),
      ),
    );
  }
}

class EntryDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  EntryDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: kPrimaryGreen)),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['headline'] ?? "Ohne Titel", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kPrimaryGreen)),
            SizedBox(height: 8),
            Text(data['date_string'] ?? "", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(15)),
              child: Text(data['text'] ?? "", style: TextStyle(fontSize: 18, color: kTextDark, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}