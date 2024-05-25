import 'package:intl/intl.dart';

class DatetimeUtil {
  // FORMAT: 26-Jan-1993
  static String formatToDateOnly(DateTime? dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime ?? DateTime.now());
  }

  // FORMAT: 1993-01-26 00:00:00.000
  static DateTime getDateTimeFromString(String day, String month, String year) {
    DateTime dob = DateTime.parse('$year-$month-$day');
    return dob;
  }
}
