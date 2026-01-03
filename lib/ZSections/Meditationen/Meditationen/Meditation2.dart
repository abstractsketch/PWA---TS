import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen/BoxBreathing.dart';

class Meditation2 extends StatefulWidget {
  const Meditation2({super.key});

  @override
  State<Meditation2> createState() => _Meditation2State();
}

class _Meditation2State extends State<Meditation2>
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
        weight: 7, // 7 Sekunden Pause
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 50).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 8, // 8 Sekunden schrumpfen
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
      appBar: AppBar(title: const Text("Meditation"),
        
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Animation
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
                          builder: (context) => const Meditation2()),
                    );
                  },
                  child: const Text("4 - 7 - 8 Atmung"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Boxbreathing()
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
    );
  }
}