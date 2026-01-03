import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: Colors.blue,
            spawnMaxRadius: 50,
            spawnMinSpeed: 0.1,
            spawnMaxSpeed: 10,
            particleCount: 9,
            spawnOpacity: 0.1,
            opacityChangeRate: 0.25,
          ),
        ),
        child: const Center(
          child: Text(
            'Background Animation',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}