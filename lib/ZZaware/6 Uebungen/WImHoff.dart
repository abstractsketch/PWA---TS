import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/main.dart';


enum BreathingPhase { ready, breathing, retention, recovery, finished }

class WimHoffBreathwork extends StatefulWidget {
  const WimHoffBreathwork({super.key});

  @override
  State<WimHoffBreathwork> createState() => _WimHoffBreathworkState();
}

class _WimHoffBreathworkState extends State<WimHoffBreathwork>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballAnimation;

  BreathingPhase _currentPhase = BreathingPhase.ready;
  int _breathCount = 0;
  int _timerSeconds = 0;
  int _round = 1; 
  String _instruction = "Setze dich bequem hin oder leg dich auf den Boden.\nVersuche möglichst tief einzuatmen und komplett auszuatmen.\nViel Spaß!";
  Timer? _countdownTimer;
  
  // PAUSE-LOGIK
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _ballAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
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
        // Animation dort fortsetzen, wo sie war
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

      await _runBreathingPhase();
      await _checkPause();

      await _runRetentionPhase();
      await _checkPause();
      
      await _runRecoveryPhase();
      await _checkPause();

      if (r < 3) {
        setState(() => _instruction = "Runde $r beendet. Atme kurz durch...");
        await Future.delayed(const Duration(seconds: 15));
        await _checkPause();
      }
    }

    setState(() {
      _currentPhase = BreathingPhase.finished;
      _instruction = "Alle 3 Runden beendet!";
    });
  }

  Future<void> _runBreathingPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.breathing;
      _breathCount = 0;
    });

    for (int i = 1; i <= 30; i++) {
      await _checkPause();
      if (!mounted) return;
      setState(() {
        _breathCount = i;
        _instruction = "Einatmen";
      });

      _controller.duration = const Duration(milliseconds: 1800);
      await _controller.forward();

      await Future.delayed(const Duration(milliseconds: 100));

      await _checkPause();
      setState(() => _instruction = "Ausatmen");

      _controller.duration = const Duration(milliseconds: 1800);
      await _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 100));

    }
  }

  Future<void> _runRetentionPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.retention;
      _timerSeconds = _round * 30;
      _instruction = "Halte den Atem...";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) { // Timer läuft nur, wenn nicht pausiert
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

  Future<void> _runRecoveryPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.recovery;
      _instruction = "Tief EINATMEN!";
    });

    _controller.duration = const Duration(seconds: 5);
    await _controller.forward();

    await _checkPause();
    setState(() {
      _timerSeconds = 15;
      _instruction = "Halten...";
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
    _controller.reverse(); 
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = _currentPhase != BreathingPhase.ready && _currentPhase != BreathingPhase.finished;

    return Scaffold(
      backgroundColor: AppColors.tealPrimary,
      body: Center(
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
                            const Text(
                              "Wim-Hoff-Atmung",
                              style: TextStyle(
                                color: AppColors.cardWhite, 
                                fontSize: 20, 
                                fontWeight: FontWeight.bold // Sieht als Überschrift meist besser aus
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
          
            if (isRunning)
              Text("RUNDE $_round / 3", style: const TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 2)),
            const SizedBox(height: 40),

            

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
            
            // DYNAMISCHER BUTTON (START ODER PAUSE/PLAY)
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
              // PAUSE / PLAY BUTTON
              IconButton(
                iconSize: 64,
                onPressed: _togglePause,
                icon: Icon(
                  _isPaused ? Icons.play_circle_fill : Icons.pause_circle_filled,
                  color: AppColors.orangeStart,
                ),
              ),

            SizedBox(height: 50, child: _buildStatusText()),

            const SizedBox(height: 80),

            
          ],
        ),
      ),
    );
  }

  Widget _buildBallContent() {
    if (_currentPhase == BreathingPhase.breathing) {
      return Text("$_breathCount", style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold));
    }
    return const SizedBox.shrink();
  }

  Widget _buildStatusText() {
    if (_currentPhase == BreathingPhase.retention || _currentPhase == BreathingPhase.recovery) {
      return Text("Noch ${_timerSeconds}s", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.cardWhite));
    }
    return const SizedBox.shrink();
  }
}

/*import 'dart:async';
import 'package:flutter/material.dart';

// --- FARBPALETTE ---
class AppColors {
  static const Color tealPrimary = Color(0xFF28869E);
  static const Color tealDark = Color(0xFF1B5E6F);
  static const Color orangeStart = Color(0xFFFF9966);
  static const Color orangeEnd = Color(0xFFFF5E62);
  static const Color bgLight = Color(0xFFF0F4F6);
}

enum BreathingPhase { ready, breathing, retention, recovery, finished }

class WimHoffBreathwork extends StatefulWidget {
  const WimHoffBreathwork({super.key});

  @override
  State<WimHoffBreathwork> createState() => _WimHoffBreathworkState();
}

class _WimHoffBreathworkState extends State<WimHoffBreathwork>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballAnimation;

  BreathingPhase _currentPhase = BreathingPhase.ready;
  int _breathCount = 0;
  int _timerSeconds = 0;
  int _round = 1; // Aktuelle Runde
  String _instruction = "Setze dich bequem hin oder leg dich auf den Boden.\n Versuche möglichst tief einzuatmen und komplett auszuatmen.\nViel Spaß!";
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _ballAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // --- LOGIK-STEUERUNG ---

  Future<void> _startExercise() async {
    for (int r = 1; r <= 3; r++) {
      if (!mounted) return;
      setState(() {
        _round = r;
      });

      await _runBreathingPhase();
      if (!mounted) return;
      
      await _runRetentionPhase();
      if (!mounted) return;
      
      await _runRecoveryPhase();
      if (!mounted) return;

      // Kurze Pause zwischen den Runden, außer nach der letzten
      if (r < 3) {
        setState(() {
          _instruction = "Runde $r beendet. Atme kurz durch...";
        });
        await Future.delayed(const Duration(seconds: 15));
      }
    }

    setState(() {
      _currentPhase = BreathingPhase.finished;
      _instruction = "Alle 3 Runden beendet!\nNimm dir einen kurzen Moment zum Entspannen.";
    });
  }

  // Phase 1: 30 Kraft-Atemzüge
  Future<void> _runBreathingPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.breathing;
      _breathCount = 0;
    });

    for (int i = 1; i <= 30; i++) {
      if (!mounted) return;
      setState(() {
        _breathCount = i;
        _instruction = "Einatmen";
      });

      _controller.duration = const Duration(milliseconds: 1200);
      await _controller.forward();

      setState(() {
        _instruction = "Ausatmen";
      });

      _controller.duration = const Duration(milliseconds: 1200);
      await _controller.reverse();
    }
  }

  // Phase 2: Luft anhalten (leer) - Steigert sich um 30s pro Runde
  Future<void> _runRetentionPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.retention;
      _timerSeconds = _round * 30; // Runde 1: 30s, Runde 2: 60s, Runde 3: 90s
      _instruction = "Halte den Atem...";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        completer.complete();
      }
    });

    await completer.future;
  }

  // Phase 3: Erholungsatmung - Einatmen & 15 Sek halten
  Future<void> _runRecoveryPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.recovery;
      _instruction = "Tief EINATMEN!";
    });

    _controller.duration = const Duration(seconds: 5);
    await _controller.forward();

    setState(() {
      _timerSeconds = 15;
      _instruction = "Halten...";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        completer.complete();
      }
    });

    await completer.future;
    _controller.reverse(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            
            // Runden-Anzeige oben
            if (_currentPhase != BreathingPhase.ready && _currentPhase != BreathingPhase.finished)
              Text(
                "RUNDE $_round / 3",
                style: const TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 2),
              ),
            const SizedBox(height: 40),

            // --- FESTE BOX FÜR DEN BALL ---
            SizedBox(
              height: 320,
              child: Center(
                child: AnimatedBuilder(
                  animation: _ballAnimation,
                  builder: (context, child) {
                    double size = 150 + (150 * _ballAnimation.value);
                    return Container(
                      width: size,
                      height: size,
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
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(child: _buildBallContent()),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 60),

            // --- FESTE BOX FÜR ANLEITUNGSTEXT ---
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bgLight,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- FESTE BOX FÜR STATUS ---
            SizedBox(
              height: 50,
              child: _buildStatusText(),
            ),

            const SizedBox(height: 20),

            // --- START/RESTART BUTTON ---
            Opacity(
              opacity: (_currentPhase == BreathingPhase.ready || _currentPhase == BreathingPhase.finished) ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !(_currentPhase == BreathingPhase.ready || _currentPhase == BreathingPhase.finished),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeStart,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _startExercise,
                  child: Text(
                    _currentPhase == BreathingPhase.ready ? "Start" : "Training wiederholen",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBallContent() {
    if (_currentPhase == BreathingPhase.breathing) {
      return Text(
        "$_breathCount",
        style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      );
    }
    if (_currentPhase == BreathingPhase.retention || _currentPhase == BreathingPhase.recovery) {
      return const Icon(Icons.timer_outlined, color: Colors.white, size: 40);
    }
    return const Icon(Icons.air, color: Colors.white, size: 40);
  }

  Widget _buildStatusText() {
    if (_currentPhase == BreathingPhase.retention || _currentPhase == BreathingPhase.recovery) {
      return Text(
        "Noch ${_timerSeconds}s",
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.orangeEnd),
      );
    }
    return const SizedBox.shrink();
  }
}
*/


/*//Alte Version

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: WimHofBreathingPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// --- FARBPALETTE ---
class AppColors {
  static const Color tealPrimary = Color(0xFF28869E);
  static const Color tealDark = Color(0xFF1B5E6F);
  static const Color orangeStart = Color(0xFFFF9966);
  static const Color orangeEnd = Color(0xFFFF5E62);
  static const Color bgLight = Color(0xFFF0F4F6);
}

enum BreathingPhase { ready, breathing, retention, recovery, finished }

class WimHofBreathingPage extends StatefulWidget {
  const WimHofBreathingPage({super.key});

  @override
  State<WimHofBreathingPage> createState() => _WimHofBreathingPageState();
}

class _WimHofBreathingPageState extends State<WimHofBreathingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballAnimation;

  BreathingPhase _currentPhase = BreathingPhase.ready;
  int _breathCount = 0;
  int _timerSeconds = 0;
  int _round = 0;
  String _instruction = "Bereit für die erste Runde?";
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _ballAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // --- LOGIK-STEUERUNG ---

  Future<void> _startExercise() async {
    await _runBreathingPhase();
    if (!mounted) return;
    await _runRetentionPhase();
    if (!mounted) return;
    await _runRecoveryPhase();
  }

  // Phase 1: 30 Kraft-Atemzüge
  Future<void> _runBreathingPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.breathing;
      _breathCount = 0;
      
    });

    for (int i = 1; i <= 30; i++) {
      if (!mounted) return;
      setState(() {
        _breathCount = i;
        _instruction = "Einatmen";
      });

      // Einatmen (1.2s)
      _controller.duration = const Duration(milliseconds: 1200);
      await _controller.forward();

      setState(() {
        _instruction = "Ausatmen";
      });

      // Ausatmen (1.2s)
      _controller.duration = const Duration(milliseconds: 1200);
      await _controller.reverse();
    }
  }

  // Phase 2: Luft anhalten (leer) - 30 Sek
  Future<void> _runRetentionPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.retention;
      _timerSeconds = 30;
      _instruction = "Halten deinen Atem für $_timerSeconds Sekunden";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        completer.complete();
      }
    });

    await completer.future;
  }

  // Phase 3: Erholungsatmung - Einatmen & 15 Sek halten
  Future<void> _runRecoveryPhase() async {
    setState(() {
      _currentPhase = BreathingPhase.recovery;
      _instruction = "Tief einatmen!";
    });

    // Tiefes Einatmen (5s)
    _controller.duration = const Duration(seconds: 5);
    await _controller.forward();

    setState(() {
      _timerSeconds = 15;
      _instruction = "Halten...";
    });

    Completer completer = Completer();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        completer.complete();
      }
    });

    await completer.future;

    setState(() {
      _currentPhase = BreathingPhase.finished;
      _instruction = "Runde beendet.";
    });
    _controller.reverse(); // Ball zurück auf Normalmaß
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          //Rundenanzeige
            // --- FESTE BOX FÜR DEN BALL ---
            SizedBox(
              height: 320, // Etwas mehr als die maximale Ballgröße (300)
              child: Center(
                child: AnimatedBuilder(
                  animation: _ballAnimation,
                  builder: (context, child) {
                    double size = 150 + (150 * _ballAnimation.value);
                    return Container(
                      width: size,
                      height: size,
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
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _buildBallContent(),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 80),

            // --- FESTE BOX FÜR ANLEITUNGSTEXT ---
            SizedBox(
              height: 40, // Reserviert Platz für 1-2 Zeilen Text
              child: Text(
                _instruction,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bgLight,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- FESTE BOX FÜR STATUS (Zähler/Timer) ---
            SizedBox(
              height: 50, // Reserviert Platz, damit der Button unten nicht springt
              child: _buildStatusText(),
            ),

            const SizedBox(height: 20),

            // --- START BUTTON ---
            // Damit der Button immer an der gleichen Stelle bleibt, 
            // nutzen wir hier Visibility oder Opacity statt eines If-Statements
            Opacity(
              opacity: (_currentPhase == BreathingPhase.ready || _currentPhase == BreathingPhase.finished) ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !(_currentPhase == BreathingPhase.ready || _currentPhase == BreathingPhase.finished),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeStart,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (_currentPhase == BreathingPhase.finished) {
                      setState(() => _currentPhase = BreathingPhase.ready);
                    }
                    _startExercise();
                  },
                  child: Text(
                    _currentPhase == BreathingPhase.ready ? "Start" : "Erneut starten",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildBallContent() {
    if (_currentPhase == BreathingPhase.breathing) {
      return Text(
        "$_breathCount",
        style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      );
    }
    if (_currentPhase == BreathingPhase.retention || _currentPhase == BreathingPhase.recovery) {
      return const Icon(Icons.timer_outlined, color: Colors.white, size: 40);
    }
    return const Icon(Icons.air, color: Colors.white, size: 40);
  }

  Widget _buildStatusText() {
    if (_currentPhase == BreathingPhase.breathing) {
      return Text(
        "Atemzug $_breathCount von 30",
        style: const TextStyle(fontSize: 16, color: Colors.white),
      );
    }
    if (_currentPhase == BreathingPhase.retention || _currentPhase == BreathingPhase.recovery) {
      return Text(
        "Noch ${_timerSeconds}s",
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.orangeEnd),
      );
    }
    return const SizedBox.shrink();
  }
}

*/