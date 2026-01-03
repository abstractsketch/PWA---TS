import 'package:flutter/material.dart';
import 'dart:async';

class Atemeins extends StatefulWidget {
  const Atemeins({super.key});

  @override
  State<Atemeins> createState() => _AtemeinsState();
}

class _AtemeinsState extends State<Atemeins> with SingleTickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF6B8E70);
  static const Color backgroundColor = Color(0xFFF9F9F2);

  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  
  String _statusText = "Bereit?";
  int _counter = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _sizeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 1), _startBreathingCycle);
  }

  void _startBreathingCycle() async {
    if (!mounted) return;

    setState(() { _statusText = "Einatmen"; _counter = 4; });
    _startTimer();
    _controller.duration = const Duration(seconds: 4);
    _controller.forward();
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;
    setState(() { _statusText = "Halten"; _counter = 7; });
    _startTimer();
    _controller.duration = const Duration(milliseconds: 1750);
    await Future.delayed(const Duration(seconds: 7));

    if (!mounted) return;
    _controller.stop();
    setState(() { _statusText = "Ausatmen"; _counter = 8; });
    _startTimer();
    _controller.duration = const Duration(seconds: 8);
    _controller.reverse();
    await Future.delayed(const Duration(seconds: 8));

    if (mounted) _startBreathingCycle();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_counter > 1) { _counter--; } else { t.cancel(); }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("4-7-8 Atmung"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Container(
                  width: 250 * _sizeAnimation.value,
                  height: 250 * _sizeAnimation.value,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen,
                        blurRadius: 30,
                        spreadRadius: 10 * _sizeAnimation.value,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            Text(_statusText, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryGreen)),
            const SizedBox(height: 10),
            Text("$_counter s", style: const TextStyle(fontSize: 20, color: Colors.black54)),
            const SizedBox(height: 100),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Übung beenden", style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}