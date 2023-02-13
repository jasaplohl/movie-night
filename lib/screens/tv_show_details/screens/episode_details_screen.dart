import 'package:flutter/material.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/services/common_services.dart';

class EpisodeDetailsScreen extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailsScreen({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(episode.name),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(episode.name, style: Theme.of(context).textTheme.headlineLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
                    ),
                    Text(episode.voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,),
                    Text(" (${formatNumber(episode.voteCount)})"),
                  ],
                ),
                Text("Season: ${episode.seasonNumber.toString()}"),
                Text("Episode: ${episode.episodeNumber.toString()}"),
                if (episode.airDate != null) Text("Air date: ${formatDateString(episode.airDate!)}"),
              ],
            )
          ),
          if(episode.stillPath != null) Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Image.network(getBackdropUrl(episode.stillPath!)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(episode.overview.isEmpty ? "No overview" : episode.overview),
          ),
        ],
      ),
    );
  }
}
