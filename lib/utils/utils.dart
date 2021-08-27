import 'package:intl/intl.dart';

class Utils {
  static String convertMillSecsToDateString(int millisecondsSinceEpoch) {
    DateFormat timeFormat;
    final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat('hh:mm aa').format(date).toString();
  }
}
