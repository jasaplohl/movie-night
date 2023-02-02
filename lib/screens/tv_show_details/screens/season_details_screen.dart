import 'package:flutter/material.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/rating_chip.dart';

class SeasonDetailsScreen extends StatefulWidget {
  final int tvShowId;
  final Season season;
  const SeasonDetailsScreen({Key? key, required this.tvShowId, required this.season}) : super(key: key);

  @override
  State<SeasonDetailsScreen> createState() => _SeasonDetailsScreenState();
}

class _SeasonDetailsScreenState extends State<SeasonDetailsScreen> {

  List<Episode>? episodes;

  @override
  void initState() {
    getEpisodes(widget.tvShowId, widget.season.seasonNumber).then((List<Episode> value) {
      setState(() {
        episodes = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.season.name),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            Text(widget.season.name, style: Theme.of(context).textTheme.headlineLarge),
            if(widget.season.airDate != null) Text("First air date: ${formatDate(DateTime.parse(widget.season.airDate!))}"),
            Text("Episode count: ${widget.season.episodeCount}"),
            if(widget.season.overview.isNotEmpty) Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Text(widget.season.overview)
            ),
            if(widget.season.posterPath != null) Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Image.network(
                getImageUrl(widget.season.posterPath!),
                width: 200,
                height: 300,
              ),
            ),
            const DividerMargin(),
            Text("Episodes", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
            // TODO: paginate the episodes list if there are more than 20 episodes
            episodes == null ? const LoadingSpinner() : Column(
              children: [
                for(final Episode episode in episodes!) ListTile(
                  leading: episode.stillPath != null ? FadeInImage.assetNetwork(
                    image: getBackdropUrl(episode.stillPath!),
                    placeholder: "lib/assets/images/default_img.webp",
                    fit: BoxFit.cover,
                    width: 40,
                    height: 60,
                  ) : Image.asset(
                    "lib/assets/images/default_img.webp",
                    fit: BoxFit.cover,
                    width: 40,
                    height: 60,
                  ),
                  title: Text("Episode ${episode.episodeNumber}"),
                  subtitle: Text(episode.name),
                  trailing: RatingChip(rating: episode.voteAverage),
                  dense: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
