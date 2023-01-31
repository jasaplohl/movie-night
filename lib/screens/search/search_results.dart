import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/screens/search/screens/search_results_actors.dart';
import 'package:movie_night/screens/search/screens/search_results_media.dart';

class SearchResults extends StatelessWidget {
  final String query;
  const SearchResults({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              indicatorColor: Theme.of(context).primaryColorLight,
                tabs: const [
                  Tab(text: "Movies"),
                  Tab(text: "TV Shows",),
                  Tab(text: "Actors",),
                ]
            ),
          ),
          body: TabBarView(
              children: [
                SearchResultsMedia(mediaType: MediaType.movie, query: query),
                SearchResultsMedia(mediaType: MediaType.tv, query: query),
                SearchResultsActors(query: query,)
              ],
          ),
        )
    );
  }
}
