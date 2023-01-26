import 'package:flutter/material.dart';

class MoviesGenreScreen extends StatefulWidget {
  const MoviesGenreScreen({Key? key}) : super(key: key);

  @override
  State<MoviesGenreScreen> createState() => _MoviesGenreScreenState();
}

class _MoviesGenreScreenState extends State<MoviesGenreScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Movies by genre"),
    );
  }
}
