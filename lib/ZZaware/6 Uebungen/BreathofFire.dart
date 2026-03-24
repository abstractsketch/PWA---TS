import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projekt_i/main.dart';

enum BreathingPhase { ready, breathing, retention, finished }

class Breathoffire extends StatefulWidget {
  const Breathoffire({super.key});

  @override
  State<Breathoffire> createState() => _BreathoffireState();
}

class _BreathoffireState extends State<Breathoffire>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballAnimation;

  BreathingPhase _currentPhase = BreathingPhase.ready;
  int _timerSeconds = 0;
  int _round = 1;
  String _instruction = "Setze dich aufrecht hin.\nFokus auf die stoßweise Ausatmung durch die Nase.\nDer Bauch pumpt aktiv.";
  Timer? _countdownTimer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    // Der Controller ist für die schnellen Stöße zuständig
    _controller = AnimationController(vsync: this);
    _ballAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  Future<void> _checkPause() async {
    while (_isPaused) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _controller.stop();
      } else {
        if (_controller.status == AnimationStatus.forward) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // --- LOGIK-STEUERUNG ---

  Future<void> _startExercise() async {
    setState(() => _isPaused = false);
    for (int r = 1; r <= 3; r++) {
      if (!mounted) return;
      setState(() => _round = r);

      // Phase 1: Feueratem (ca. 30-45 Sekunden)
      await _runFireBreathingPhase(seconds: 30 + (r * 5));
      await _checkPause();

      // Phase 2: Kurzes Halten (Stille nach dem Sturm)
      await _runRetentionPhase(seconds: 15);
      await _checkPause();

      if (r < 3) {
        setState(() => _instruction = "Runde $r geschafft. Entspanne kurz...");
        await Future.delayed(const Duration(seconds: 5));
        await _checkPause();
      }
    }

    setState(() {
      _currentPhase = BreathingPhase.finished;
      _instruction = "Energie geladen! Genieße den Fokus.";
    });
  }

  Future<void> _runFireBreathingPhase({required int seconds}) async {
    setState(() {
      _currentPhase = BreathingPhase.breathing;
      _timerSeconds = seconds;
      _instruction = "AKTIV AUSATMEN";
    });

    // Timer für die Gesamtdauer der Runde
    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_timerSeconds > 0) {
          setState(() => _timerSeconds--);
        } else {
          timer.cancel();
          completer.complete();
        }
      }
    });

    // Die Animations-Schleife für das "Pumpen"
    while (!completer.isCompleted) {
      await _checkPause();
      if (!mounted) break;

      // Einatmen (passiv, etwas langsamer)
      _controller.duration = const Duration(milliseconds: 450);
      await _controller.forward();

      await _checkPause();
      
      // Ausatmen (aktiv, ruckartig - der "Feuer-Stoß")
      _controller.duration = const Duration(milliseconds: 250);
      await _controller.reverse();
    }
    await completer.future;
  }

  Future<void> _runRetentionPhase({required int seconds}) async {
    setState(() {
      _currentPhase = BreathingPhase.retention;
      _timerSeconds = seconds;
      _instruction = "Stille & Fokus\nAtem ruhig fließen lassen";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_timerSeconds > 0) {
          setState(() => _timerSeconds--);
        } else {
          timer.cancel();
          completer.complete();
        }
      }
    });
    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = _currentPhase != BreathingPhase.ready && _currentPhase != BreathingPhase.finished;

    return Scaffold(
      backgroundColor: AppColors.tealPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Header (Back Button & Title)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Breath of Fire",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Spacer(),

            if (isRunning)
              Text("RUNDE $_round / 3", style: const TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 2)),
            
            const SizedBox(height: 40),

            // Animation Ball
            Center(
              child: AnimatedBuilder(
                animation: _ballAnimation,
                builder: (context, child) {
                  double size = 120 + (130 * _ballAnimation.value);
                  return Container(
                    width: size, height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.orangeStart, AppColors.orangeEnd],
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orangeEnd.withOpacity(_currentPhase == BreathingPhase.breathing ? 0.6 : 0.2),
                          blurRadius: 40, spreadRadius: 10
                        ),
                      ],
                    ),
                    child: Center(
                      child: _currentPhase == BreathingPhase.retention 
                        ? const Icon(Icons.self_improvement, size: 60, color: Colors.white)
                        : null
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 60),

            // Instruktionen
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(_instruction, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.bgLight),
                ),
              ),
            ),

            // Timer Anzeige
            if (isRunning)
              Text("${_timerSeconds}s", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),

            const Spacer(),

            // Control Buttons
            if (!isRunning)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangeStart,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: _startExercise,
                child: Text(_currentPhase == BreathingPhase.ready ? "Session starten" : "Neustart"),
              )
            else
              IconButton(
                iconSize: 70,
                onPressed: _togglePause,
                icon: Icon(_isPaused ? Icons.play_circle_fill : Icons.pause_circle_filled, color: Colors.white),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}