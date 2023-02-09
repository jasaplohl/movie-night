import 'package:flutter/material.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/media_row.dart';

class ProfileScreen extends StatefulWidget {
  final AuthProvider authProvider;
  const ProfileScreen({Key? key, required this.authProvider}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Media>? favouriteMovies;
  List<Media>? favouriteTvShows;
  List<Media>? favouritePeople;

  @override
  void initState() {
    // TODO: implement initState
    _setFavouriteMovies(widget.authProvider.favouriteMovies.values.toList());
    _setFavouriteTvShows(widget.authProvider.favouriteTvShows.values.toList());
    _setFavouritePeople(widget.authProvider.favouritePeople.values.toList());
    super.initState();
  }

  void _setFavouriteMovies(List<Favourite> favourites) {
    getMediaFromFavourites(favourites)
      .then((value) {
        setState(() {
          favouriteMovies = value;
        });
      })
      .catchError((err) {
        showErrorDialog(context, err.toString());
      });
  }

  void _setFavouriteTvShows(List<Favourite> favourites) {
    getMediaFromFavourites(favourites)
      .then((value) {
        setState(() {
          favouriteTvShows = value;
        });
      })
      .catchError((err) {
        showErrorDialog(context, err.toString());
      });
  }

  void _setFavouritePeople(List<Favourite> favourites) {
    getMediaFromFavourites(favourites)
      .then((value) {
        setState(() {
          favouritePeople = value;
        });
      })
      .catchError((err) {
        showErrorDialog(context, err.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if(favouriteMovies != null && favouriteMovies!.isNotEmpty) MediaRow(
          title: "Favourite Movies",
          media: favouriteMovies,
        ),
        if(favouriteTvShows != null && favouriteTvShows!.isNotEmpty) MediaRow(
          title: "Favourite TV Shows",
          media: favouriteTvShows,
        ),
        if(favouritePeople != null && favouritePeople!.isNotEmpty) MediaRow(
          title: "Favourite People",
          media: favouritePeople,
        ),
      ],
    );
  }
}
