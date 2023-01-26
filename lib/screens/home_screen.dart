import 'package:flutter/material.dart';
import 'package:movie_night/services/movie_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    getPopularMovies(page: 1).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Movie list"),
      ),
    );
  }
}
