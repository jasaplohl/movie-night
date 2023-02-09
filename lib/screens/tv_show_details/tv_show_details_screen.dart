import 'package:flutter/material.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/screens/tv_show_details/widgets/episode_section.dart';
import 'package:movie_night/screens/tv_show_details/widgets/networks_section.dart';
import 'package:movie_night/screens/tv_show_details/widgets/seasons_section.dart';
import 'package:movie_night/screens/tv_show_details/widgets/tv_show_details_header.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/widgets/add_to_favourites_button.dart';
import 'package:movie_night/widgets/credits_section.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/recommendations_section.dart';
import 'package:movie_night/widgets/trailer.dart';
import 'package:movie_night/widgets/watchlist_fab.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvShowDetails == null ? "" : tvShowDetails!.name),
        actions: [
          if(tvShowDetails != null) AddToFavouritesButton(
            id: tvShowDetails!.id,
            mediaType: MediaType.tv,
          ),
        ],
      ),
      floatingActionButton: tvShowDetails != null ? WatchlistFab(
        id: tvShowDetails!.id,
        mediaType: MediaType.tv,
      ) : null,
      body: tvShowDetails == null ?
      const LoadingSpinner() :
      ListView(
        children: [
          TvShowDetailsHeader(
            name: tvShowDetails!.name,
            voteAverage: tvShowDetails!.voteAverage,
            voteCount: tvShowDetails!.voteCount,
            firstAirDate: tvShowDetails!.firstAirDate,
            lastAirDate: tvShowDetails!.lastAirDate,
            runtime: tvShowDetails!.episodeRunTime,
            originalLanguage: tvShowDetails!.originalLanguage,
            homepage: tvShowDetails!.homepage,
          ),
          GenreRow(genres: tvShowDetails!.genres),
          if(tvShowDetails!.videos.isNotEmpty) Trailer(youtubeKey: getTrailerUrl(tvShowDetails!.videos)),
          if(tvShowDetails!.backdropPath != null) Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Image.network(getBackdropUrl(tvShowDetails!.backdropPath!)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(tvShowDetails!.tagline != null && tvShowDetails!.tagline!.isNotEmpty) Text(
                    tvShowDetails!.tagline!,
                    style: Theme.of(context).textTheme.headlineSmall
                ),
                if(tvShowDetails!.overview.isNotEmpty) Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(tvShowDetails!.overview),
                ),
              ],
            ),
          ),
          if(tvShowDetails!.nextEpisodeToAir != null) EpisodeSection(sectionTitle: "Coming soon", episode: tvShowDetails!.nextEpisodeToAir!),
          if(tvShowDetails!.lastEpisodeToAir != null) EpisodeSection(sectionTitle: "Last episode to air", episode: tvShowDetails!.lastEpisodeToAir!),
          NetworksSection(networks: tvShowDetails!.networks),
          if(tvShowDetails!.seasons.isNotEmpty) SeasonsSection(
            tvShowId: widget.tvShowId,
            numberOfSeasons: tvShowDetails!.numberOfSeasons,
            seasons: tvShowDetails!.seasons,
          ),
          if(tvShowDetails!.cast.isNotEmpty) CreditsSection(sectionTitle: "Cast", credits: tvShowDetails!.cast),
          if(tvShowDetails!.crew.isNotEmpty) CreditsSection(sectionTitle: "Crew", credits: tvShowDetails!.crew),
          if(tvShowDetails!.recommendations.isNotEmpty) RecommendationsSection(recommended: tvShowDetails!.recommendations),
        ],
      ),
    );
  }
}
