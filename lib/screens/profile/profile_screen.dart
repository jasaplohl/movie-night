import 'package:flutter/material.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/media_row.dart';
import 'package:movie_night/screens/profile/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Media>? _favourites;
  List<Media>? _watchlist;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    _setFavourites(authProvider.latestFavourites);
    _setWatchlist(authProvider.latestWatchlist);
    super.didChangeDependencies();
  }

  void _setFavourites(List<SavedMedia> favourites) {
    getMediaFromSaved(favourites)
      .then((value) {
        setState(() {
          _favourites = value;
        });
      })
      .catchError((err) {
        showErrorDialog(context, err.toString());
      });
  }

  void _setWatchlist(List<SavedMedia> watchlist) {
    getMediaFromSaved(watchlist)
      .then((value) {
        setState(() {
          _watchlist = value;
        });
      })
      .catchError((err) {
        showErrorDialog(context, err.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AuthProvider>(
          builder: (context, value, child) {
            if(value.user != null) {
              return Text(
                  value.user!.providerData[0].displayName ?? "Your Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight)
              );
            }
            return child!;
          },
          child: Text("Your Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight)),
        ),
      ),
      drawer: const UserDrawer(),
      body: ListView(
        children: [
          if(_favourites != null) MediaRow(
            title: "Latest Favourites",
            media: _favourites,
          ),
          if(_watchlist != null) MediaRow(
            title: "Latest items on your watchlist",
            media: _watchlist,
          ),
        ],
      ),
    );
  }
}
