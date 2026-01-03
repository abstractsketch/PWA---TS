/*import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:projekt_i/Login%202/Seiten2/Meditationen.dart';
import 'package:video_player/video_player.dart';

class Meditation1 extends StatefulWidget {
  const Meditation1({super.key});

  @override
  State<Meditation1> createState() => _Meditation1State();
}

class _Meditation1State extends State<Meditation1> {
  final player = AudioPlayer();
  late VideoPlayerController _videoController;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  @override
  void initState() {
    super.initState();

    // 🎵 Audio einrichten
    player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');

    player.positionStream.listen((p) {
      setState(() => position = p);
    });

    player.durationStream.listen((d) {
      if (d != null) setState(() => duration = d);
    });

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.pause();
      }
    });

    
 

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Meditationen"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Meditationen()),
              );
            },
          ),
        ),
        body: Stack(
          children: [
            // 🎵 UI oben drauf
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), // halbtransparent für Lesbarkeit
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(formatDuration(position),
                            style: const TextStyle(color: Colors.white)),
                        Slider(
                          min: 0.0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
                          onChanged: handleSeek,
                        ),
                        Text(formatDuration(duration),
                            style: const TextStyle(color: Colors.white)),
                        IconButton(
                          icon: Icon(
                            player.playing ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: handlePlayPause,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Text('ja');
    throw UnimplementedError();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:projekt_i/ZSections/Meditationen/Meditationen.dart';

class Meditation1 extends StatefulWidget {
  const Meditation1({super.key});

  @override
  State<Meditation1> createState() => _Meditation1State();
}

class _Meditation1State extends State<Meditation1> {
  final player = AudioPlayer();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  @override
  void initState() {
    super.initState();

    // 🎵 Audio einrichten
    player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');

    player.positionStream.listen((p) {
      setState(() => position = p);
    });

    player.durationStream.listen((d) {
      if (d != null) setState(() => duration = d);
    });

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.pause();
      }
    });

  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditationen"),
        
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // halbtransparent für Lesbarkeit
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(formatDuration(position),
                          style: const TextStyle(color: Colors.white)),
                      Slider(
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
                        onChanged: handleSeek,
                      ),
                      Text(formatDuration(duration),
                          style: const TextStyle(color: Colors.white)),
                      IconButton(
                        icon: Icon(
                          player.playing ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: handlePlayPause,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
