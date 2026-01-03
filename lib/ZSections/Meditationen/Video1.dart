import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoplayerWidget extends StatefulWidget {
  const VideoplayerWidget ({ Key? key }) : super(key: key);

  @override
  State<VideoplayerWidget> createState() => _VideoplayerWidgetState();
}

class _VideoplayerWidgetState extends State<VideoplayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://www.w3schools.com/html/mov_bbb.mp4', // Dein Video-URL
    )..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web Video Player")),
      body: Center(
        child: _isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),

                const Padding(padding: EdgeInsets.all(20)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all <Color> (Colors.blue),
                        fixedSize: MaterialStateProperty.all(const Size(70,70)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      onPressed: (){
                        _controller.pause();
                      }, 
                      child: const Icon(Icons.pause),
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all <Color> (Colors.blue),
                        fixedSize: MaterialStateProperty.all(const Size(70,70)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      onPressed: (){
                        _controller.play();
                      },  
                      child: const Icon(Icons.play_arrow),
                    ),
                  ]
                )
              ],
            )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
  
  /* 
  late VideoPlayerController _videoPlayerController;
  
  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(
      'lib/Videos/fg.mp4'
    )..initialize().then((_){

      setState(() {
        
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: _videoPlayerController.value.isInitialized 
        ? 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio:_videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController)
            ),

            const Padding(padding: EdgeInsets.all(20)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all <Color> (Colors.blue),
                    fixedSize: MaterialStateProperty.all(const Size(70,70)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  onPressed: (){
                    _videoPlayerController.pause();
                  }, 
                  child: const Icon(Icons.pause),
                ),
                const Padding(padding: EdgeInsets.all(2)),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all <Color> (Colors.blue),
                    fixedSize: MaterialStateProperty.all(const Size(70,70)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  onPressed: (){
                    _videoPlayerController.play();
                  },  
                  child: const Icon(Icons.play_arrow),
                ),
              ]
            )
          ],
        ) : Container(),
      ),
    );
  }
}*/