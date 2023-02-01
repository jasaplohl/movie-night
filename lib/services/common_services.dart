import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat.yMMMMd().format(date);
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