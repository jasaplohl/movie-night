import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}

T? cast<T>(dynamic x) => x is T ? x : null;