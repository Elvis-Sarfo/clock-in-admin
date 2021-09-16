import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final Function(DateTimeRange?)? onChanged;
  final EdgeInsets? padding;

  CustomDateRangePicker({
    this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    Key? key,
  }) : super(key: key);

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTimeRange? newDateRange;
  @override
  Widget build(BuildContext context) {
    DateTimeRange _dateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    return Padding(
      padding: widget.padding!,
      child: InkWell(
        onTap: () async {
          newDateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            initialDateRange: _dateRange,
          );

          setState(() {
            widget.onChanged!(newDateRange);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDataRangeItem('From',
                "${newDateRange == null ? formatDate(_dateRange.start) : formatDate(newDateRange!.start)}"),
            const SizedBox(
              width: 10,
            ),
            _buildDataRangeItem('Until',
                "${newDateRange == null ? formatDate(_dateRange.end) : formatDate(newDateRange!.end)}"),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    String _date = DateFormat('d MMMM, y').format(date);
    return '$_date';
  }

  Row _buildDataRangeItem(String text, String dateRange) {
    return Row(
      children: [
        Icon(
          Icons.date_range_outlined,
          size: 20.0,
          color: Colors.black45,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 12),
            ),
            Text(
              dateRange,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.black87,
              ),
            )
          ],
        ),
      ],
    );
  }
}
