import 'package:flutter/material.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    Uri videoUri = Uri.parse(widget.videoUrl);
    _controller = VideoPlayerController.networkUrl(videoUri)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true); // Loop the video
    //_controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = _controller.value.aspectRatio;
    final isPortrait = aspectRatio < 1; // Checking if the video is portrait
    double videoHeight = Responsive.height(context, .8);

    double height = size.height;
    double width = size.width;

    if (isPortrait) {
      height = size.height;
      width = height / aspectRatio;
    } else {
      height = width / aspectRatio;
    }

    return GestureDetector(
      // onTap: _togglePlayPause,
      onLongPress: _togglePlayPause,
      onTap: _togglePlayPause,
      child: SizedBox(
        width: width,
        height: videoHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            if (!_controller.value.isPlaying)
              const Icon(
                Icons.play_arrow,
                size: 50.0,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
