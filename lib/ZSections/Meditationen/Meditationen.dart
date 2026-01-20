import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/BoxBreathing.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation1.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation2.dart';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/6%20Uebungen/Meditationen/BoxBreathing.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation1.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation2.dart';
import 'package:projekt_i/ZSections/Meditationen/listitemdata.dart';

class Meditationen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Meditationen"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header Bild
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              child: Image.network(
                "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),

            /// Kategorien
            _buildCategory(
              title: "Achtsamkeit",
              items: [
                ListItemData(
                  "Meditation Basics",
                  "10 min",
                  "Einsteiger",
                  "https://picsum.photos/100/100?1",
                  Meditation1(),
                ),
                ListItemData(
                  "Atemübungen",
                  "7 min",
                  "Fortgeschritten",
                  "https://picsum.photos/100/100?2",
                  Meditation2(),
                ),
              ],
            ),

            _buildCategory(
              title: "Wahrnehmen",
              items: [
                ListItemData(
                  "Dankbarkeit",
                  "5 min",
                  "Einsteiger",
                  "https://picsum.photos/100/100?3",
                  Boxbreathing(),
                ),
                ListItemData(
                  "Tägliche Reflexion",
                  "8 min",
                  "Erfahren",
                  "https://picsum.photos/100/100?4",
                  Meditation1(),
                ),
              ],
            ),

            _buildCategory(
              title: "Wellbeing",
              items: [
                ListItemData(
                  "Entspannung",
                  "12 min",
                  "Einsteiger",
                  "https://picsum.photos/100/100?5",
                  Meditation2(),
                ),
                ListItemData(
                  "Entspannungsrituale",
                  "6 min",
                  "Fortgeschritten",
                  "https://picsum.photos/100/100?6",
                  Boxbreathing(),
                ),
              ],
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory({
    required String title,
    required List<ListItemData> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),

          ...items.map((item) => _buildListItem(item)).toList(),
        ],
      ),
    );
  }

  /// EINZELNES LIST TILE
  Widget _buildListItem(ListItemData data) {
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.duration, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 2),
                Text(
                  "Level: ${data.level}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),

            /// Navigation
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => data.destination),
              );
            },
          ),
        );
      },
    );
  }
}




/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Meditationen"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header bild
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              child: Image.network(
                "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),

            /// --- KATEGORIEN ---
            _buildCategory(
              title: "Achtsamkeit",
              items: [
                ListItemData("Meditation Basics", "10 min", "Einsteiger",
                    "https://picsum.photos/100/100?1"),
                ListItemData("Atemübungen", "7 min", "Fortgeschritten",
                    "https://picsum.photos/100/100?2"),
              ],
            ),

            _buildCategory(
              title: "Wahrnehmen",
              items: [
                ListItemData("Dankbarkeit", "5 min", "Einsteiger",
                    "https://picsum.photos/100/100?3"),
                ListItemData("Tägliche Reflexion", "8 min", "Erfahren",
                    "https://picsum.photos/100/100?4"),
              ],
            ),

            _buildCategory(
              title: "Wellbeing",
              items: [
                ListItemData("Entspannung", "12 min", "Einsteiger",
                    "https://picsum.photos/100/100?5"),
                ListItemData("Entspannungsrituale", "6 min", "Fortgeschritten",
                    "https://picsum.photos/100/100?6"),
              ],
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// --- KATEGORIE BLOCK ---
  Widget _buildCategory({
    required String title,
    required List<ListItemData> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),

          ...items.map((item) => _buildListItem(item)).toList(),
        ],
      ),
    );
  }

  /// --- EINZELNES LISTTILE ---
  Widget _buildListItem(ListItemData data) {
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.duration, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 2),
                Text("Level: ${data.level}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),

            /// NAVIGATION → Meditation1()
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Meditation1()),
              );
            },
          ),
        );
      },
    );
  }
}

/// --- Datenmodell ---
class ListItemData {
  final String title;
  final String duration;
  final String level;
  final String imageUrl;

  ListItemData(this.title, this.duration, this.level, this.imageUrl);
}
*/