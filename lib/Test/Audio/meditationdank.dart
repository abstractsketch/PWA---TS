import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Meditationdank extends StatefulWidget {
  const Meditationdank({super.key});

  @override
  State<Meditationdank> createState() => _MeditationdankState();
}

class _MeditationdankState extends State<Meditationdank> {
  static const Color bgLightGreen = Color(0xFF90C992);
  static const Color playerDarkGreen = Color(0xFF5A7A60);

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((d) {
      if(mounted) setState(() => _duration = d);
    });
    _audioPlayer.onPositionChanged.listen((p) {
      if(mounted) setState(() => _position = p);
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      if(mounted) setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });

    try {
      // FÜR WEB: AssetSource ist die sicherste Methode
      // Voraussetzung: assets/audios/meditation.mp3 existiert und ist in pubspec.yaml registriert
      await _audioPlayer.setSource(AssetSource('audios/Meditation1.mp3'));
    } catch (e) {
      print("Fehler beim Laden: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.resume();
      }
      setState(() => _isPlaying = !_isPlaying);
    } catch (e) {
      print("Playback Fehler: $e");
    }
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightGreen,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              left: 20,
              child: Text(
                'Dankbarkeits-\nMeditation',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),

            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: playerDarkGreen.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.spa, color: Colors.white30, size: 80),
              ),
            ),

            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: playerDarkGreen,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(_formatTime(_position), style: const TextStyle(color: Colors.white, fontSize: 12)),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.white,
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white30,
                            ),
                            child: Slider(
                              min: 0,
                              max: _duration.inSeconds.toDouble() > 0 ? _duration.inSeconds.toDouble() : 1.0,
                              value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble() > 0 ? _duration.inSeconds.toDouble() : 1.0),
                              onChanged: (value) async {
                                await _audioPlayer.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                        ),
                        Text(_formatTime(_duration), style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.white),
                      onPressed: _togglePlay,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}