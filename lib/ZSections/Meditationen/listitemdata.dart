import 'package:flutter/material.dart';

class ListItemData {
  final String title;
  final String duration;
  final String level;
  final String imageUrl;
  final Widget destination; 

  ListItemData(
    this.title,
    this.duration,
    this.level,
    this.imageUrl,
    this.destination,
  );
}