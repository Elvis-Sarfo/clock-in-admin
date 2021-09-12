import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends ChangeNotifier {
  BuildContext context;

  DateRangePicker({required this.context});

  DateTimeRange _dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  DateTimeRange get dateRange => _dateRange;

  pickDateRange() async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: _dateRange,
    );
    if (newDateRange == null) return null;
    _dateRange = newDateRange;
    notifyListeners();
  }

  String getFromDate() {
    // ignore: unnecessary_null_comparison
    if (_dateRange != null) {
      String date = DateFormat('d MMMM, y').format(_dateRange.start).toString();
      return '$date';
    } else {
      return 'No Date';
    }
  }

  String getEndDate() {
    // ignore: unnecessary_null_comparison
    if (_dateRange != null) {
      String date = DateFormat('d MMMM, y').format(_dateRange.end).toString();
      return '$date';
    } else {
      return 'Select Date';
    }
  }
}
