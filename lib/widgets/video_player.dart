import 'package:fake_story/widgets/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({Key? key}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController? controller;

  String dataSource =
      "https://shivanesboutique.com/pub/media/S_MAM_VIDEO_10042021.mp4";
  // String asset = "assets/my_video.mp4";

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(dataSource)
      ..initialize().then((_) {
        setState(() {});
      });

    // controller!.play();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayer(context, controller!);
  }
}
