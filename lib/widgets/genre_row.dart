import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/widgets/genre_chip.dart';

class GenreRow extends StatelessWidget {
  final List<Genre> genres;
  const GenreRow({Key? key, required this.genres}) : super(key: key);

  List<Widget> getGenreItems() {
    List<Widget> genreWidgetList = [];
    for (Genre element in genres) {
      genreWidgetList.add(GenreChip(genre: element));
    }
    return genreWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: getGenreItems(),
    );
  }
}
