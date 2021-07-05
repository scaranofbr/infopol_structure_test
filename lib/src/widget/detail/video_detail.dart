import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:better_player/better_player.dart';

class VideoDetail extends StatefulWidget {
  final String title;
  final DateTime? date;
  final String time;
  final String link;

  const VideoDetail({required this.link, Key? key, required this.title, this.date, required this.time})
      : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    var betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.link);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9, placeholder: Container()),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dateString = '';
    if (widget.date != null) {
      dateString = DateFormat('dd/MM/yyyy').format(widget.date!);
    }
    return ListView(
      children: [
        Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 40),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController,
          ),
        ),
        SizedBox(height: 15),
        Text(widget.time + ' - ' + dateString),
        SizedBox(height: 40)
      ],
    );
  }
}
