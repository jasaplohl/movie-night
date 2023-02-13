import 'package:flutter/material.dart';
import 'package:movie_night/screens/search/search_results.dart';

class CustomSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: use debounce to show search suggestions (or stream_transform)
    // TODO: make a custom search page?
    return const Center(
      child: Text("Search your favourite movies, TV shows and actors."),
    );
  }
  
}