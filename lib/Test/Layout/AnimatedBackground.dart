import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedBackgroundPage extends StatefulWidget {
  const AnimatedBackgroundPage({super.key});

  @override
  State<AnimatedBackgroundPage> createState() => _AnimatedBackgroundPageState();
}

class _AnimatedBackgroundPageState extends State<AnimatedBackgroundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Ball> _balls = [];
  final Random _random = Random();
  bool _isAnimating = true;

  // --- KONFIGURATION ---
  final Color _backgroundColor = const Color(0xFFC8D5ED);
  final Color _ballBaseColor = Colors.orangeAccent;
  final int _numberOfBalls = 3; 
  // ---------------------

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(_updateBalls)
     ..repeat();

    // Bälle erstellen
    for (int i = 0; i < _numberOfBalls; i++) {
      _balls.add(Ball(
        color: _ballBaseColor.withOpacity(0.4 + _random.nextDouble() * 0.4),
        radius: 100 + _random.nextDouble() * 100,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- HIER WAR DER FEHLER ---
  // Wir müssen setState aufrufen, damit sich das Bild aktualisiert
  void _updateBalls() {
    setState(() {
      for (var ball in _balls) {
        ball.position += ball.velocity;

        // Abprallen an den Wänden
        if (ball.position.dx < -100 || ball.position.dx > ball.screenSize.width + 100) {
          ball.velocity = Offset(-ball.velocity.dx, ball.velocity.dy);
        }
        if (ball.position.dy < -100 || ball.position.dy > ball.screenSize.height + 100) {
          ball.velocity = Offset(ball.velocity.dx, -ball.velocity.dy);
        }
      }
    });
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimating = !_isAnimating;
      if (_isAnimating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Initialisierung beim ersten Aufbauen
          if (_balls.isNotEmpty && _balls.first.screenSize == Size.zero) {
             for (var ball in _balls) {
               ball.screenSize = Size(constraints.maxWidth, constraints.maxHeight);
               ball.position = Offset(
                 _random.nextDouble() * constraints.maxWidth,
                 _random.nextDouble() * constraints.maxHeight,
               );

               double speedFactor = 10.0;
               ball.velocity = Offset(
                 (_random.nextDouble() - 0.5) * speedFactor,
                 (_random.nextDouble() - 0.5) * speedFactor
               );
             }
          }

          return Stack(
            children: [
              // 1. Die Bälle
              ..._balls.map((ball) => Positioned(
                left: ball.position.dx - ball.radius,
                top: ball.position.dy - ball.radius,
                child: Container(
                  width: ball.radius * 2,
                  height: ball.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ball.color,
                        ball.color.withOpacity(0.0),
                      ],
                      stops: const [0.3, 1.0],
                    ),
                  ),
                ),
              )),

              // 2. Blur Filter
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // 3. Inhalt
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Es bewegt sich!",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "3 Bälle, schnell & blurry",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleAnimation,
        backgroundColor: Colors.blueGrey.shade700,
        icon: Icon(_isAnimating ? Icons.pause : Icons.play_arrow, color: Colors.white),
        label: Text(
          _isAnimating ? "Stop" : "Start",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Ball {
  Offset position;
  Offset velocity;
  double radius;
  Color color;
  Size screenSize;

  Ball({
    this.position = Offset.zero,
    this.velocity = Offset.zero,
    required this.radius,
    required this.color,
    this.screenSize = Size.zero,
  });
}