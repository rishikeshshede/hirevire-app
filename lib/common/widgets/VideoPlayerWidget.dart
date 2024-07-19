import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    Uri videoUri = Uri.parse(widget.videoUrl);
    _controller = VideoPlayerController.networkUrl(videoUri)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true); // Loop the video
    _controller.play();
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
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = _controller.value.aspectRatio;
    final isPortrait = aspectRatio < 1; // Checking if the video is portrait

    double height = size.height;
    double width = size.width;

    if (isPortrait) {
      height = size.height;
      width = height / aspectRatio;
    } else {
      height = width / aspectRatio;
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            VideoPlayer(_controller),
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
