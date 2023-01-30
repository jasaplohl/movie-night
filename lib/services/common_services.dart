import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat.yMMMMd().format(date);
  } catch(err) {
    print(err);
    return date.toString();
  }
}