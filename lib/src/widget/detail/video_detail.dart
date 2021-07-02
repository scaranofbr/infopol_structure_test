import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/article/video_article.dart';
import 'package:intl/intl.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  final VideoArticle model;

  const VideoDetail({required this.model, Key? key}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  Future<void> _initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.model.link);
    return await videoPlayerController.initialize();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dateString = '';
    if (widget.model.data != null) {
      dateString = DateFormat('dd/MM/yyyy').format(widget.model.data!);
    }
    return ListView(
      children: [
        Text(widget.model.title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 40),
        FutureBuilder<void>(
            future: _initVideoPlayer(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    chewieController = ChewieController(
                      videoPlayerController: videoPlayerController,
                      autoPlay: false,
                      aspectRatio: 16/9,
                    );
                    return Chewie(controller: chewieController);
                  }
              }
            }),
        SizedBox(height: 15),
        Text(widget.model.ora.toString() + ' - ' + dateString),
        SizedBox(height: 40)
      ],
    );
  }
}
