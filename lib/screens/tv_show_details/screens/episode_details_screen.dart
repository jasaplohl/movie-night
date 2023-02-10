import 'package:flutter/material.dart';

// TODO: Display episode details

class EpisodeDetailsScreen extends StatefulWidget {
  final int episodeNumber;
  const EpisodeDetailsScreen({Key? key, required this.episodeNumber}) : super(key: key);

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Episode - ${widget.episodeNumber}"),),
      body: const Center(
        child: Text("Not implemented yet!"),
      ),
    );
  }
}
