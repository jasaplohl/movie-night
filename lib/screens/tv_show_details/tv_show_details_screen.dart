import 'package:flutter/material.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/loading_spinner.dart';

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
      print(value.episodeRunTime);
      setState(() {
        tvShowDetails = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  Widget getBody() {
    if(tvShowDetails == null) {
      return const LoadingSpinner();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            Text(tvShowDetails!.name, style: Theme.of(context).textTheme.headlineLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(formatDate(DateTime.parse(tvShowDetails!.firstAirDate!))),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
                    ),
                    Text(tvShowDetails!.voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,),
                    Text(" (${formatNumber(tvShowDetails!.voteCount)})")
                  ],
                ),
              ],
            ),
            Text("Episode runtime: ${tvShowDetails!.episodeRunTime} min")
          ],
        ),
      );
    }
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
