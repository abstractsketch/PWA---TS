import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SimpleAudioPlayer extends StatefulWidget {
  final String audioUrl;
  const SimpleAudioPlayer({super.key, required this.audioUrl});

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  final AudioPlayer _player = AudioPlayer(playerId: 'main_player');
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  PlayerState _playerState = PlayerState.stopped;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Events
    _player.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _player.onPlayerStateChanged.listen((state) {
      setState(() => _playerState = state);
    });

    _player.onPlayerComplete.listen((event) {
      // wenn fertig, reset position
      setState(() {
        _position = _duration;
        _playerState = PlayerState.completed;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes)}:${two(d.inSeconds % 60)}";
  }

  Future<void> _play() async {
    setState(() => _isLoading = true);
    try {
      // Erst Quelle setzen (besser für Fehlerdiagnose)
      await _player.setSource(UrlSource(widget.audioUrl));
      // Optional: setze ReleaseMode, z.B. loop oder stop
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.resume();
    } catch (e, st) {
      // Fehler anzeigen
      debugPrint('Error beim Abspielen: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Abspielen: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Pause-Error: $e');
    }
  }

  Future<void> _stop() async {
    try {
      await _player.stop();
      setState(() => _position = Duration.zero);
    } catch (e) {
      debugPrint('Stop-Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _playerState == PlayerState.playing;
    return Scaffold(
      appBar: AppBar(title: const Text('Robuster Audio Player')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // großer Play/Pause
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.12))],
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  IconButton(
                    iconSize: 80,
                    icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                    onPressed: () async {
                      if (isPlaying) {
                        await _pause();
                      } else {
                        await _play();
                      }
                    },
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Slider (sicher: wenn Dauer 0 -> disabled)
            Slider(
              min: 0,
              max: _duration.inMilliseconds.toDouble().clamp(1, double.infinity),
              value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
              onChanged: _duration > Duration.zero
                  ? (value) {
                      final newPos = Duration(milliseconds: value.toInt());
                      _player.seek(newPos);
                      setState(() => _position = newPos);
                    }
                  : null,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(_format(_position)),
              Text(_format(_duration)),
            ]),

            const SizedBox(height: 16),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton.icon(
                onPressed: _stop,
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}