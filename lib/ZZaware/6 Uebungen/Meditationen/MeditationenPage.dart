import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/main.dart';

class MeditationPage extends StatefulWidget {
  final int nummer;
  final String titel;

  const MeditationPage({
    super.key,
    required this.nummer,
    required this.titel,
  });


  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> with TickerProviderStateMixin {
  // --- ANIMATION STATE ---
  late AnimationController _animController;
  final List<FloatingBall> _balls = [];
  final Random _rng = Random();
  int nummer = 1;

  // --- AUDIO LOGIK STATE (Aus Source A übernommen) ---
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    
    // 1. Animation initialisieren (Source B)
    _animController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 1)
    )..repeat();

    for (int i = 0; i < 7; i++) {
      _balls.add(FloatingBall(
        radius: _rng.nextDouble() * 50 + 30,
        x: _rng.nextDouble(), 
        y: _rng.nextDouble(),
        dx: (_rng.nextDouble() - 0.5) * 0.0005, 
        dy: (_rng.nextDouble() - 0.5) * 0.0005,
      ));
    }

    // 2. Audio initialisieren (Logik aus Source A)
    _initAudio();
  }

  // Logik aus Source A übertragen
  Future<void> _initAudio() async {
    _audioPlayer = AudioPlayer();

    // Listener: Gesamtdauer
    _audioPlayer.onDurationChanged.listen((d) {
      if(mounted) setState(() => duration = d);
    });
    
    // Listener: Aktuelle Position
    _audioPlayer.onPositionChanged.listen((p) {
      if(mounted) setState(() => position = p);
    });
    
    // Listener: Wenn Audio fertig ist
    _audioPlayer.onPlayerComplete.listen((event) {
      if(mounted) setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });

    try {
      // Datei laden (Pfad aus Source A übernommen)
      await _audioPlayer.setSource(AssetSource('audios/Meditation${widget.nummer}.mp3'));
    } catch (e) {
      debugPrint("Fehler beim Laden: $e");
    }
  }

  Future<void> _togglePlay() async {
    try {
      if (isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.resume();
      }
      setState(() => isPlaying = !isPlaying);
    } catch (e) {
      debugPrint("Playback Fehler: $e");
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _audioPlayer.dispose(); // Audio aufräumen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealPrimary, 
      body: Stack(
        children: [
          
          // 1. ANIMIERTE BÄLLE MIT VERLAUF (Source B UI)
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return CustomPaint(
                painter: BallPainter(_balls),
                child: Container(),
              );
            },
          ),

          // 2. BLUR EFFEKT (Source B UI)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: AppColors.tealDark.withOpacity(0.2), 
            ),
          ),

          // 3. UI INHALT (Source B UI mit Source A Logik verknüpft)
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), 
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, size: 28),
                              color: AppColors.cardWhite,
                              onPressed: () {
                                
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => const ResponsiveLayout(initialIndex: 3),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                              },
                            ),
                            const SizedBox(width: 4), // Kleiner Abstand zwischen Pfeil und Text
                            /*const Text(
                              "Body-Scan",
                              style: TextStyle(
                                color: AppColors.cardWhite, 
                                fontSize: 20, 
                                fontWeight: FontWeight.bold // Sieht als Überschrift meist besser aus
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                      const Icon(Icons.more_horiz, color: Colors.white70),
                    ],
                  ),
                ),
                
                const Spacer(), // Drückt alles andere nach unten

                // Cover Art
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
                    ]
                  ),
                  child: const Icon(Icons.spa, size: 50, color: Colors.white60),
                ),
                
                const SizedBox(height: 30),

                // Titel & Info
                Text(
                  widget.titel,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Geführte Meditation',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 40),

                // Player Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 20), // Padding angepasst für bessere Breite
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                          activeTrackColor: AppColors.orangeStart,
                          inactiveTrackColor: Colors.white12,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 0.0),
                          min: 0,
                          max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1.0,
                          onChanged: (value) async {
                            await _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(position), style: const TextStyle(color: Colors.white38, fontSize: 10)),
                          Text(_formatDuration(duration), style: const TextStyle(color: Colors.white38, fontSize: 10)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 10s Zurück Button
                          IconButton(
                            icon: const Icon(Icons.replay_10, size: 24, color: Colors.white60),
                            onPressed: () {
                               final newPos = position - const Duration(seconds: 10);
                               _audioPlayer.seek(newPos.isNegative ? Duration.zero : newPos);
                            },
                          ),
                          const SizedBox(width: 30),
                          
                          // Play/Pause Button
                          GestureDetector(
                            onTap: _togglePlay,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [AppColors.orangeStart, AppColors.orangeEnd],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.orangeEnd.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  )
                                ]
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 30),
                          
                          // 10s Vorwärts Button 
                          IconButton(
                            icon: const Icon(Icons.forward_10, size: 24, color: Colors.white60),
                            onPressed: () {
                               final newPos = position + const Duration(seconds: 10);
                               if(newPos < duration) _audioPlayer.seek(newPos);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Formatierung
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

// Bälle

class FloatingBall {
  double x; 
  double y;
  double dx; 
  double dy;
  double radius;

  FloatingBall({
    required this.x, required this.y, 
    required this.dx, required this.dy, 
    required this.radius
  });

  void update() {
    x += dx;
    y += dy;
    if (x < -0.1 || x > 1.1) dx *= -1;
    if (y < -0.1 || y > 1.1) dy *= -1;
  }
}

class BallPainter extends CustomPainter {
  final List<FloatingBall> balls;

  BallPainter(this.balls);

  @override
  void paint(Canvas canvas, Size size) {
    for (var ball in balls) {
      ball.update();
      
      final Offset center = Offset(ball.x * size.width, ball.y * size.height);
      final Rect rect = Rect.fromCircle(center: center, radius: ball.radius);

      final Paint paint = Paint()
        ..shader = const LinearGradient(
          colors: [AppColors.orangeStart, AppColors.orangeEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect);

      canvas.drawCircle(center, ball.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}