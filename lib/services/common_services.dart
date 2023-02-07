import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/models/video_model.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDateString(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat.yMMMMd().format(parsedDate);
  } catch(err) {
    return date.toString();
  }
}

String getYear(DateTime date) {
  try {
    return DateFormat.y().format(date);
  } catch(err) {
    return date.toString();
  }
}

String formatNumber(num number) {
  NumberFormat formatter = NumberFormat.compact();
  return formatter.format(number);
}

String getImageUrl(String imageName) {
  String url = "https://image.tmdb.org/t/p/w500$imageName";
  return url;
}

String getBackdropUrl(String imageName) {
  String url = "https://image.tmdb.org/t/p/w1280$imageName";
  return url;
}

// TODO: check if type = Youtube
String getTrailerUrl(List<Video> videos) {
  for(Video video in videos) {
    if(video.type == "Trailer") {
      return video.key;
    }
  }
  return videos[0].key;
}

void goToUrl(String url, BuildContext context) async {
  launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication
  ).then((bool status) {
    if(!status) {
      showErrorDialog(context, "Could not open the requested url.");
    }
  });
}