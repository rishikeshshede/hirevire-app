import 'package:intl/intl.dart';

class DatetimeUtil {
  // FORMAT: 26-Jan-1993
  static String formatToDateOnlyString(DateTime? dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime ?? DateTime.now());
  }

  // FORMAT: 1993-01-26 00:00:00.000
  static DateTime getDateTimeFromString(String day, String month, String year) {
    DateTime date = DateTime.parse('$year-$month-$day');
    return date;
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return 'an hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return 'a minute ago';
    } else {
      return 'just now';
    }
  }
}
