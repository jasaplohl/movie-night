import 'package:flutter/material.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/screens/tv_show_details/screens/season_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/utils/constants.dart';
import 'package:movie_night/utils/pagination_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/pagination.dart';

class SeasonsSection extends StatefulWidget {
  final int tvShowId;
  final int numberOfSeasons;
  final List<Season> seasons;
  const SeasonsSection({
    Key? key,
    required this.tvShowId,
    required this.numberOfSeasons,
    required this.seasons,
  }) : super(key: key);

  @override
  State<SeasonsSection> createState() => _SeasonsSectionState();
}

class _SeasonsSectionState extends State<SeasonsSection> {

  int currentPage = 1;
  int totalPages = 1;
  int totalItems = 0;
  PaginationService<Season>? paginationService;
  List<Season>? displayedSeasons;

  @override
  void initState() {
    paginationService = PaginationService(items: widget.seasons, maxItemsPerPage: itemsPerPageSm);

    setState(() {
      totalPages = paginationService!.totalPages;
      totalItems = paginationService!.itemCount;
      displayedSeasons = paginationService!.getItemsForPage(currentPage);
    });
    super.initState();
  }

  void onSeasonClick(Season season) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonDetailsScreen(tvShowId: widget.tvShowId, season: season),));
  }
  void onPageChange(int newPage) {
    setState(() {
      currentPage = newPage;
      displayedSeasons = paginationService!.getItemsForPage(newPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DividerMargin(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Seasons (${widget.numberOfSeasons})", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
            )
          ],
        ),
        Text("Page $currentPage of $totalPages.", textAlign: TextAlign.center),
        for(Season season in displayedSeasons!) ListTile(
          leading: season.posterPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(season.posterPath!),
            placeholder: "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: imageWidthSm,
            height: imageHeightSm,
          ) : Image.asset(
            "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: imageWidthSm,
            height: imageHeightSm,
          ),
          title: season.airDate != null ?
          Text("${season.name} (${getYear(DateTime.parse(season.airDate!))})") :
          Text(season.name),
          subtitle: Text("Episodes: ${season.episodeCount}"),
          onTap: () => onSeasonClick(season),
        ),
        Pagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChange: onPageChange
        )
      ],
    );
  }
}
