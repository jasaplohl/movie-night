import 'package:flutter/material.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/network.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/screens/tv_show_details/screens/season_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/custom_chip.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/trailer.dart';

class TvShowDetailsScreen extends StatefulWidget {
  final int tvShowId;
  const TvShowDetailsScreen({Key? key, required this.tvShowId}) : super(key: key);

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {

  TvShowDetails? tvShowDetails;

  @override
  void initState() {
    getTvShowDetails(widget.tvShowId).then((TvShowDetails value) {
      setState(() {
        tvShowDetails = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  void onSeasonClick(Season season) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsScreen(tvShowId: widget.tvShowId, season: season),));
  }

  Widget getNextEpisodeSection() {
    Episode nextEpisode = tvShowDetails!.nextEpisodeToAir!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerMargin(),
        Text("Coming soon", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        const SizedBox(height: 10,),
        if(nextEpisode.airDate != null) Text("Air date: ${formatDate(DateTime.parse(nextEpisode.airDate!))}"),
        Text("Season ${nextEpisode.seasonNumber}"),
        ListTile(
          leading: nextEpisode.stillPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(nextEpisode.stillPath!),
            placeholder: "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: 40,
            height: 60,
          ) : null,
          title: Text("${nextEpisode.name} (episode ${nextEpisode.episodeNumber})", style: Theme.of(context).textTheme.labelLarge,),
          subtitle: Text(nextEpisode.overview.isNotEmpty ? nextEpisode.overview : "No description available."),
        ),
      ],
    );
  }

  Widget getLastEpisodeSection() {
    Episode lastEpisode = tvShowDetails!.lastEpisodeToAir!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerMargin(),
        Text("Last episode to air", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        const SizedBox(height: 10,),
        if(lastEpisode.airDate != null) Text("Air date: ${formatDate(DateTime.parse(lastEpisode.airDate!))}"),
        Text("Season ${lastEpisode.seasonNumber}"),
        ListTile(
          leading: lastEpisode.stillPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(lastEpisode.stillPath!),
            placeholder: "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: 40,
            height: 60,
          ) : null,
          title: Text("${lastEpisode.name} (episode ${lastEpisode.episodeNumber})", style: Theme.of(context).textTheme.labelLarge,),
          subtitle: Text(lastEpisode.overview.isNotEmpty ? lastEpisode.overview : "No description available."),
        ),
      ],
    );
  }

  Widget getNetworksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerMargin(),
        Text("Networks", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for(final Network network in tvShowDetails!.networks) CustomChip(
              label: network.name,
              imagePath: network.logoPath != null ? getImageUrl(network.logoPath!) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget getSeasonsSection() {
    final List<Season> seasons = tvShowDetails!.seasons;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerMargin(),
        Text("Seasons (${tvShowDetails!.numberOfSeasons})", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        for(Season season in seasons) ListTile(
          leading: season.posterPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(season.posterPath!),
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
          title: season.airDate != null ?
          Text("${season.name} (${getYear(DateTime.parse(season.airDate!))})") :
          Text(season.name),
          subtitle: Text("Episodes: ${season.episodeCount}"),
          onTap: () => onSeasonClick(season),
        ),
      ],
    );
  }

  Widget getBody() {
    if(tvShowDetails == null) {
      return const LoadingSpinner();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            Text(tvShowDetails!.name, style: Theme.of(context).textTheme.headlineLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
                ),
                Text(tvShowDetails!.voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,),
                Text(" (${formatNumber(tvShowDetails!.voteCount)})"),
              ],
            ),
            Text("First air date: ${formatDate(DateTime.parse(tvShowDetails!.firstAirDate))}"),
            const SizedBox(height: 10),
            Text("Last air date: ${formatDate(DateTime.parse(tvShowDetails!.lastAirDate))}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(tvShowDetails!.episodeRunTime != null) Text("Episode runtime: ${tvShowDetails!.episodeRunTime} min"),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Icon(Icons.speaker_notes),
                    ),
                    Text(tvShowDetails!.originalLanguage.toUpperCase()),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            if(tvShowDetails!.homepage != null) ElevatedButton(
              onPressed: () => goToUrl(tvShowDetails!.homepage!, context),
              child: const Text("Home page"),
            ),
            GenreRow(genres: tvShowDetails!.genres),
            if(tvShowDetails!.videos != null && tvShowDetails!.videos!.isNotEmpty) Trailer(youtubeKey: getTrailerUrl(tvShowDetails!.videos!)),
            if(tvShowDetails!.backdropPath != null) Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Image.network(getBackdropUrl(tvShowDetails!.backdropPath!)),
            ),
            if(tvShowDetails!.tagline != null) Text(
                tvShowDetails!.tagline!,
                style: Theme.of(context).textTheme.headlineSmall
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(tvShowDetails!.overview),
            ),
            if(tvShowDetails!.nextEpisodeToAir != null) getNextEpisodeSection(),
            if(tvShowDetails!.lastEpisodeToAir != null) getLastEpisodeSection(),
            getNetworksSection(),
            getSeasonsSection(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvShowDetails == null ? "" : tvShowDetails!.name),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColorLight,)
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, color: Colors.red,)
          )
        ],
      ),
      body: getBody(),
    );
  }
}
