import 'package:flutter/material.dart';

class CustomDateRangePicker extends StatefulWidget {
  final Function(dynamic)? onChanged;

  CustomDateRangePicker({this.onChanged, Key? key}) : super(key: key);

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  var newDateRange;
  @override
  Widget build(BuildContext context) {
    DateTimeRange _dateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                "${newDateRange == null ? _dateRange.start : newDateRange.getFromDate()}"),
            _buildDataRangeItem('Until',
                "${newDateRange == null ? _dateRange.end : newDateRange.getEndDate()}"),
          ],
        ),
      ),
    );
  }

  Row _buildDataRangeItem(String text, String dateRange) {
    return Row(
      children: [
        Icon(Icons.date_range_outlined, size: 24.0),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              dateRange,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ],
    );
  }
}
