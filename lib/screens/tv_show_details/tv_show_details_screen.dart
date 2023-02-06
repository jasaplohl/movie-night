import 'package:flutter/material.dart';
import 'package:movie_night/models/network_model.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/screens/tv_show_details/screens/season_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/widgets/episode_section.dart';
import 'package:movie_night/screens/tv_show_details/widgets/tv_show_details_header.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/constants.dart';
import 'package:movie_night/widgets/credits_section.dart';
import 'package:movie_night/services/pagination_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/custom_chip.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/pagination.dart';
import 'package:movie_night/widgets/recommendations_section.dart';
import 'package:movie_night/widgets/trailer.dart';

class TvShowDetailsScreen extends StatefulWidget {
  final int tvShowId;
  const TvShowDetailsScreen({Key? key, required this.tvShowId}) : super(key: key);

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {

  TvShowDetails? tvShowDetails;

  int currentSeasonPage = 1;
  int totalSeasonPages = 1;
  int totalSeasonItems = 0;
  PaginationService<Season>? paginationService;
  List<Season>? displayedSeasons;

  @override
  void initState() {
    getTvShowDetails(widget.tvShowId).then((TvShowDetails value) {
      paginationService = PaginationService(items: value.seasons, maxItemsPerPage: itemsPerPageSm);
      setState(() {
        tvShowDetails = value;
        totalSeasonPages = paginationService!.totalPages;
        totalSeasonItems = paginationService!.itemCount;
        displayedSeasons = paginationService!.getItemsForPage(currentSeasonPage);
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  void onSeasonClick(Season season) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsScreen(tvShowId: widget.tvShowId, season: season),));
  }
  void onSeasonPageChange(int newPage) {
    setState(() {
      currentSeasonPage = newPage;
      displayedSeasons = paginationService!.getItemsForPage(newPage);
    });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DividerMargin(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Seasons (${tvShowDetails!.numberOfSeasons})", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
          ],
        ),
        Text("Page $currentSeasonPage of $totalSeasonPages.", textAlign: TextAlign.center),
        for(Season season in displayedSeasons!) ListTile(
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
        Pagination(
            currentPage: currentSeasonPage,
            totalPages: totalSeasonPages,
            onPageChange: onSeasonPageChange
        )
      ],
    );
  }

  Widget getBody() {
    if(tvShowDetails == null) {
      return const LoadingSpinner();
    } else {
      return ListView(
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
          if(tvShowDetails!.tagline != null) Text(
              tvShowDetails!.tagline!,
              style: Theme.of(context).textTheme.headlineSmall
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(tvShowDetails!.overview),
          ),
          if(tvShowDetails!.nextEpisodeToAir != null) EpisodeSection(sectionTitle: "Coming soon", episode: tvShowDetails!.nextEpisodeToAir!),
          if(tvShowDetails!.lastEpisodeToAir != null) EpisodeSection(sectionTitle: "Last episode to air", episode: tvShowDetails!.lastEpisodeToAir!),
          getNetworksSection(),
          if(displayedSeasons != null) getSeasonsSection(),
          if(tvShowDetails!.cast.isNotEmpty) CreditsSection(sectionTitle: "Cast", credits: tvShowDetails!.cast),
          if(tvShowDetails!.crew.isNotEmpty) CreditsSection(sectionTitle: "Crew", credits: tvShowDetails!.crew),
          if(tvShowDetails!.recommendations.isNotEmpty) RecommendationsSection(recommended: tvShowDetails!.recommendations),
        ],
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
