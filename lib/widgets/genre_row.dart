import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/widgets/genre_chip.dart';
import 'package:movie_night/widgets/loading_spinner.dart';

class GenreRow extends StatelessWidget {
  final List<Genre>? genres;
  const GenreRow({Key? key, this.genres}) : super(key: key);

  List<Widget> getGenreItems() {
    List<Widget> genreWidgetList = [];
    for (Genre element in genres!) {
      genreWidgetList.add(GenreChip(genre: element));
    }
    return genreWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return genres != null ? Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: getGenreItems(),
    ) : const LoadingSpinner();
  }
}
