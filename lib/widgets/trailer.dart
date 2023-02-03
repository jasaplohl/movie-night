import 'package:flutter/material.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailer extends StatefulWidget {
  final String youtubeKey;
  const Trailer({Key? key, required this.youtubeKey}) : super(key: key);

  @override
  State<Trailer> createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        hideControls: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    if(_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? YoutubePlayer(
          controller: _controller!,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true,),
            RemainingDuration(),
          ],
        )
        : const LoadingSpinner();
  }
}
