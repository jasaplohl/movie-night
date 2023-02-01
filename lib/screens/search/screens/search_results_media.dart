import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';
import 'package:movie_night/widgets/pagination.dart';

class SearchResultsMedia extends StatefulWidget {
  final MediaType mediaType;
  final String query;

  const SearchResultsMedia({
    Key? key,
    required this.mediaType,
    required this.query,
  }) : super(key: key);

  @override
  State<SearchResultsMedia> createState() => _SearchResultsMediaState();
}

class _SearchResultsMediaState extends State<SearchResultsMedia> {

  int currentPage = 1;
  int totalPages = 1;
  int totalResults = 0;
  List<Media>? searchResult;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _getSearchResults(currentPage);

    super.initState();
  }

  void _getSearchResults(int page) {
    search(widget.query, page, widget.mediaType).then((MediaRes value) {
      setState(() {
        currentPage = page;
        totalPages = value.totalPages;
        totalResults = value.totalResults;
        searchResult = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  void onPageChange(int pageNumber) {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    _getSearchResults(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return searchResult != null ?
    ListView(
      controller: scrollController,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Page $currentPage of $totalPages ($totalResults results).", textAlign: TextAlign.center),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            for (final Media element in searchResult!) MediaCard(key: ValueKey(element.id), media: element),
          ],
        ),
        Pagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChange: onPageChange
        )
      ],
    ) : const LoadingSpinner();
  }
}
