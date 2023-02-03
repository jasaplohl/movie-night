import 'package:flutter/material.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/constants.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/pagination.dart';
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

  // Pagination
  int currentPage = 1;
  int totalPages = 1;
  List<Episode>? displayedEpisodes;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getEpisodes(widget.tvShowId, widget.season.seasonNumber).then((List<Episode> value) {
      final maxPages = (value.length / maxItemsPerPage).ceil();
      setState(() {
        totalPages = maxPages > 0 ? maxPages : 1;
        episodes = value;
      });
      setEpisodesForCurrentPage();
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  void onPageChange(int newPage) {
    setState(() {
      currentPage = newPage;
    });
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    setEpisodesForCurrentPage();
  }

  void setEpisodesForCurrentPage() {
    final lowerLimit = (currentPage - 1) * maxItemsPerPage;
    final upperLimit = currentPage * maxItemsPerPage > episodes!.length ? episodes!.length : currentPage * maxItemsPerPage;
    setState(() {
      displayedEpisodes = episodes!.sublist(lowerLimit, upperLimit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.season.name),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          controller: scrollController,
          children: [
            Text(widget.season.name, style: Theme.of(context).textTheme.headlineLarge),
            if(widget.season.airDate != null) Text("First air date: ${formatDateString(widget.season.airDate!)}"),
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
            const SizedBox(height: 10,),
            displayedEpisodes == null ? const LoadingSpinner() : Column(
              children: [
                if(totalPages > 1) Text("Current page: $currentPage of $totalPages."),
                for(final Episode episode in displayedEpisodes!) ListTile(
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
                Pagination(
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onPageChange: onPageChange
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
