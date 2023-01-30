import 'package:flutter/material.dart';

class SearchResultsActors extends StatefulWidget {
  final String query;
  const SearchResultsActors({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultsActors> createState() => _SearchResultsActorsState();
}

class _SearchResultsActorsState extends State<SearchResultsActors> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This functionality is not implemented yet!"),
    );
  }
}
