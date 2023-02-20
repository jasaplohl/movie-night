import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  List<Media>? popularMovies;
  List<Media>? popularTvShows;

  @override
  void initState() {
    getPopular(mediaType: MediaType.movie).then((List<Media> value) {
      setState(() {
        popularMovies = value.length > 10 ? value.sublist(0, 10) : value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getPopular(mediaType: MediaType.tv).then((List<Media> value) {
      setState(() {
        popularTvShows = value.length > 10 ? value.sublist(0, 10) : value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          // TODO: Show watchlist
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            color: Theme.of(context).primaryColorLight,
            child: Text("Movies", style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black)),
          ),
          // TODO: Create a mediaWrap widget
          popularMovies == null ? const LoadingSpinner() : Wrap(
            direction: Axis.horizontal,
            children: [
              for(final Media media in popularMovies!) MediaCard(key: UniqueKey(), media: media,)
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            color: Theme.of(context).primaryColorLight,
            child: Text("TV Shows", style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black)),
          ),
          // TODO: Create a mediaWrap widget
          popularTvShows == null ? const LoadingSpinner() : Wrap(
            direction: Axis.horizontal,
            children: [
              for(final Media media in popularTvShows!) MediaCard(key: UniqueKey(), media: media,)
            ],
          )
        ],
    );
  }
}
