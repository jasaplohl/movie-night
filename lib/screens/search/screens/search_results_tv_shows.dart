import 'package:flutter/material.dart';

class SearchResultsTVShows extends StatefulWidget {
  final String query;
  const SearchResultsTVShows({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultsTVShows> createState() => _SearchResultsTVShowsState();
}

class _SearchResultsTVShowsState extends State<SearchResultsTVShows> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This functionality is not implemented yet!"),
    );
  }
}
