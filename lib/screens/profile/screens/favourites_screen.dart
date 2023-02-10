import 'package:flutter/material.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  List<Media>? media;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setMedia();
    super.didChangeDependencies();
  }

  Future<void> setMedia() async {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final List<Favourite> favourites = authProvider.favourites;
    try {
      final List<Media> res = await getMediaFromFavourites(favourites);
      setState(() {
        media = res;
      });
    } catch(err) {
      showErrorDialog(context, err.toString());
    }
  }

  // TODO: Pagination
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites ${media == null ? '' : '(${media!.length})'}"),),
      body: media == null ?
      const LoadingSpinner() :
      ListView(
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: [
              for (final Media element in media!) MediaCard(key: UniqueKey(), media: element),
            ],
          ),
        ],
      ),
    );
  }
}
