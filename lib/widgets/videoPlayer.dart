import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget videoPlayer(BuildContext context, VideoPlayerController controller) {
  return SizedBox(
    child: controller.value.isInitialized
        ? InkWell(
            onTap: () => controller.value.isPlaying
                ? controller.pause()
                : controller.play(),
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          )
        // ignore: sized_box_for_whitespace
        : Container(
            height: 200,
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
  );
}
