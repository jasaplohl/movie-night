import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/media_row.dart';

class MediaScreen extends StatefulWidget {
  final MediaType mediaType;
  const MediaScreen({Key? key, required this.mediaType}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {

  List<Media>? trendingDaily;
  List<Media>? trendingWeekly;
  List<Media>? popular;
  List<Media>? topRated;

  @override
  void initState() {
    initMedia();
    super.initState();
  }

  void initMedia() {
    getTrendingDaily(widget.mediaType).then((List<Media> value) {
      setState(() {
        trendingDaily = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getTrendingWeekly(widget.mediaType).then((List<Media> value) {
      setState(() {
        trendingWeekly = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getPopular(mediaType: widget.mediaType).then((List<Media> value) {
      setState(() {
        popular = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getTopRated(mediaType: widget.mediaType).then((List<Media> value) {
      setState(() {
        topRated = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MediaRow(
            title: "Trending today",
            media: trendingDaily
        ),
        MediaRow(
            title: "Trending this week",
            media: trendingWeekly
        ),
        MediaRow(
            title: "Popular",
            media: popular
        ),
        MediaRow(
            title: "Top Rated",
            media: topRated
        ),
      ],
    );
  }
}
