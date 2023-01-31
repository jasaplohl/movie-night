import 'package:flutter/material.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';

class TvShowDetailsScreen extends StatefulWidget {
  final int tvShowId;
  const TvShowDetailsScreen({Key? key, required this.tvShowId}) : super(key: key);

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {

  TvShowDetails? tvShowDetails;

  @override
  void initState() {
    getTvShowDetails(widget.tvShowId).then((TvShowDetails value) {
      setState(() {
        tvShowDetails = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  Widget getBody() {
    return const Center(
      child: Text("TV show details"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvShowDetails == null ? "" : tvShowDetails!.name),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColorLight,)
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, color: Colors.red,)
          )
        ],
      ),
      body: getBody(),
    );
  }
}
