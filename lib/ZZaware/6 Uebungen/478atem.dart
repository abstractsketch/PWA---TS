import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/main.dart'; // Zugriff auf AppColors

enum BreathingPhase { ready, inhale, hold, exhale, finished }

class Atemeins extends StatefulWidget {
  const Atemeins({super.key});

  @override
  State<Atemeins> createState() => _AtemeinsState();
}

class _AtemeinsState extends State<Atemeins> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballAnimation;

  BreathingPhase _currentPhase = BreathingPhase.ready;
  int _timerSeconds = 0; // Der Countdown-Zähler
  int _round = 1; // Aktuelle Runde
  
  // Standard-Anleitungstext
  String _instruction = "Setze dich aufrecht hin.\nZungenspitze hinter die oberen Schneidezähne.\nAtme vollständig aus.";
  
  Timer? _countdownTimer;

  // PAUSE-LOGIK
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // Ball wird größer (Einatmen) und kleiner (Ausatmen)
    _ballAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  // Hilfsfunktion: Wartet, solange Pause aktiv ist
  Future<void> _checkPause() async {
    while (_isPaused) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _controller.stop(canceled: false);
      } else {
        // Animation fortsetzen
        if (_controller.status == AnimationStatus.forward) {
          _controller.forward();
        } else if (_controller.status == AnimationStatus.reverse) {
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

  // --- LOGIK-STEUERUNG (4-7-8) ---

  Future<void> _startExercise() async {
    setState(() => _isPaused = false);
    
    // Klassische 4-7-8 Atmung: 4 Zyklen (Runden)
    for (int r = 1; r <= 4; r++) {
      if (!mounted) return;
      setState(() => _round = r);

      // 1. Einatmen (4 Sekunden)
      await _runInhalePhase();
      await _checkPause();

      // 2. Halten (7 Sekunden)
      await _runHoldPhase();
      await _checkPause();
      
      // 3. Ausatmen (8 Sekunden)
      await _runExhalePhase();
      await _checkPause();
    }

    setState(() {
      _currentPhase = BreathingPhase.finished;
      _instruction = "Übung beendet.\nSpüre der Ruhe nach.";
      _timerSeconds = 0;
    });
  }

  Future<void> _runInhalePhase() async {
    setState(() {
      _currentPhase = BreathingPhase.inhale;
      _timerSeconds = 4;
      _instruction = "Durch die Nase EINATMEN";
    });

    _controller.duration = const Duration(seconds: 4);
    _controller.forward(); // Animation startet

    await _runCountdown(4);
  }

  Future<void> _runHoldPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.hold;
      _timerSeconds = 7;
      _instruction = "Atem HALTEN";
    });

    // Animation stoppt/bleibt groß
    _controller.stop(); 

    await _runCountdown(7);
  }

  Future<void> _runExhalePhase() async {
    setState(() {
      _currentPhase = BreathingPhase.exhale;
      _timerSeconds = 8;
      _instruction = "Geräuschvoll durch den Mund AUSATMEN";
    });

    _controller.duration = const Duration(seconds: 8);
    _controller.reverse(); // Animation geht zurück

    await _runCountdown(8);
  }

  // Generische Countdown-Funktion, die Pause berücksichtigt
  Future<void> _runCountdown(int seconds) async {
    _timerSeconds = seconds;
    Completer completer = Completer();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_timerSeconds > 1) { // >1 damit wir bei 1 aufhören und der Loop handled den Rest
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
      body: Center(
        child: Column(
          children: [
            // Header (Identisch zum Template)
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
                          const SizedBox(width: 4),
                          const Text(
                            "4-7-8 Atmung",
                            style: TextStyle(
                              color: AppColors.cardWhite, 
                              fontSize: 20, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Animation Ball
            SizedBox(
              height: 320,
              child: Center(
                child: AnimatedBuilder(
                  animation: _ballAnimation,
                  builder: (context, child) {
                    double size = 150 + (150 * _ballAnimation.value);
                    return Container(
                      width: size, height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.orangeStart, AppColors.orangeEnd],
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(color: AppColors.orangeEnd.withOpacity(0.3), blurRadius: 30, spreadRadius: 5),
                        ],
                      ),
                      child: Center(child: _buildBallContent()),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 60),

            // Anweisungs-Text
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(_instruction, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.bgLight),
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            // Start / Pause Button
            if (!isRunning)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangeStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: _startExercise,
                child: Text(_currentPhase == BreathingPhase.ready ? "Start" : "Wiederholen"),
              )
            else
              IconButton(
                iconSize: 64,
                onPressed: _togglePause,
                icon: Icon(
                  _isPaused ? Icons.play_circle_fill : Icons.pause_circle_filled,
                  color: AppColors.orangeStart,
                ),
              ),

            // Status Text (Sekunden)
            SizedBox(height: 50, child: _buildStatusText()),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // Inhalt des Balls (Zeigt Sekunden an)
  Widget _buildBallContent() {
    if (_currentPhase == BreathingPhase.inhale || 
        _currentPhase == BreathingPhase.hold || 
        _currentPhase == BreathingPhase.exhale) {
      return Text("$_timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold));
    }
    return const Icon(Icons.spa, color: Colors.white, size: 50);
  }

  // Text unter dem Button (Optional, hier meist leer da Timer im Ball ist, oder zur Verdeutlichung)
  Widget _buildStatusText() {
    // Bei 4-7-8 ist der Timer im Ball oft besser sichtbar,
    // aber wir können hier den Phasennamen nochmals klein anzeigen
    if (_currentPhase != BreathingPhase.ready && _currentPhase != BreathingPhase.finished) {
       // Optional: "Sekunden" Text
       return const Text("Sekunden", style: TextStyle(color: Colors.white70, fontSize: 14));
    }
    return const SizedBox.shrink();
  }
}