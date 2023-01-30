import 'package:flutter/material.dart';
import 'package:movie_night/screens/search/screens/search_results_movies.dart';

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
                SearchResultsMovies(query: query),
                const Icon(Icons.tv),
                const Icon(Icons.person),
              ],
          ),
        )
    );
  }
}
