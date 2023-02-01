import 'package:flutter/material.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/show_error_dialog.dart';
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
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.season.name),),
      body: ListView(
        children: [
          if(widget.season.airDate != null) Text(formatDate(DateTime.parse(widget.season.airDate!))),
          Text(widget.season.overview),
          if(widget.season.posterPath != null) Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Image.network(getImageUrl(widget.season.posterPath!)),
          ),
        ],
      ),
    );
  }
}
