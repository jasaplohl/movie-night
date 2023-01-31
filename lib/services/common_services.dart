import 'package:intl/intl.dart';

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