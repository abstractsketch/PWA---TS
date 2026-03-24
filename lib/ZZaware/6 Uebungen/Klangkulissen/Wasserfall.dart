import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projekt_i/main.dart'; // Für deine AppColors

class Wasserfall extends StatefulWidget {
  const Wasserfall({super.key});

  @override
  State<Wasserfall> createState() => _WasserfallState();
}

class _WasserfallState extends State<Wasserfall>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  bool _isPlaying = false;
  final String _instruction = "Finde deine innere Ruhe.\nLasse die Gedanken mit dem Wasser fließen.";

  @override
  void initState() {
    super.initState();
    
    // Audio Setup
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop); // Automatischer Loop
    _audioPlayer.setSource(AssetSource('audios/Meditation1.mp3'));

    // Animations-Setup für den "Wellen-Effekt"
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rippleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    // Die Animation läuft dauerhaft im Loop, wenn gestartet
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _controller.stop();
    } else {
      // Nutze einen Beispiel-Sound, falls du noch kein Asset hast:
      await _audioPlayer.play(AssetSource('audios/Meditation1.mp3')); 
      _controller.repeat(reverse: true);
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nutze hier ein dunkles Blau oder Teal aus deinen AppColors
      backgroundColor: const Color(0xFF0D47A1), 
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Wasserfall Meditation",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Visuelles Element: Pulsierende Wasser-Kugel
            Center(
              child: AnimatedBuilder(
                animation: _rippleAnimation,
                builder: (context, child) {
                  double size = 180 * (_isPlaying ? _rippleAnimation.value : 1.0);
                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(_isPlaying ? 0.5 : 0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.waves,
                      size: 60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            // Instruktionen
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),

            // Play/Stop Button
            IconButton(
              iconSize: 90,
              onPressed: _toggleAudio,
              icon: Icon(
                _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}