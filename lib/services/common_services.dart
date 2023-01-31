import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat.yMMMMd().format(date);
  } catch(err) {
    return date.toString();
  }
}