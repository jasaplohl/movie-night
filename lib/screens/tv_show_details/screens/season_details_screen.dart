import 'package:flutter/material.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/services/tv_show_service.dart';

class SeasonDetailsScreen extends StatefulWidget {
  final int tvShowId;
  final Season season;
  const SeasonDetailsScreen({Key? key, required this.tvShowId, required this.season}) : super(key: key);

  @override
  State<SeasonDetailsScreen> createState() => _SeasonDetailsScreenState();
}

class _SeasonDetailsScreenState extends State<SeasonDetailsScreen> {

  @override
  void initState() {
    getEpisodes(widget.tvShowId, widget.season.seasonNumber).then((value) {
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.season.name),),
      body: ListView(
        children: [
          Text(widget.season.overview),
        ],
      ),
    );
  }
}
