import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Backgroundanimation.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/Meditation2.dart';

class Boxbreathing extends StatefulWidget {
  const Boxbreathing({super.key});

  @override
  State<Boxbreathing> createState() => _BoxbreathingState();
}

class _BoxbreathingState extends State<Boxbreathing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 19), // 4 wachsen + 7 Pause + 8 schrumpfen
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 50, end: 150).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 4, // 4 Sekunden wachsen
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(150),
        weight: 4, // 7 Sekunden Pause
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 50).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 4, // 8 Sekunden schrumpfen
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(50),
        weight: 4, // 7 Sekunde
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(); // Endlosschleife
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleAnimation() {
    setState(() {
      if (isRunning) {
        _controller.stop();
      } else {
        _controller.forward(from: 0);
      }
      isRunning = !isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation"),
        
      ),
      body: Stack(
        children: [
          // ✨ Hintergrundanimation
          const Positioned.fill(
            child: IgnorePointer(
              child: BackgroundAnimation(),
            ),
          ),

          // Inhalt oben drauf
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Animation (Kreis)
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: _animation.value,
                        height: _animation.value,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Start / Stop Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: toggleAnimation,
                  child: Text(isRunning ? "Stop" : "Start"),
                ),
              ),

              // Zwei Navigations-Buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Meditation2(),
                          ),
                        );
                      },
                      child: const Text("Atemtechnik"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Boxbreathing(),
                          ),
                        );
                      },
                      child: const Text("Box Breathing"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}