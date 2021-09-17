import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
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
            saveText: 'Select',
            builder: (BuildContext? context, Widget? child) {
              var _width = MediaQuery.of(context!).size.width;
              var _height = MediaQuery.of(context).size.height;
              const MaterialColor buttonTextColor = const MaterialColor(
                0xFF4A5BF6,
                const <int, Color>{
                  50: const Color(0xFF870A4F),
                  100: const Color(0xFF870A4F),
                  200: const Color(0xFF870A4F),
                  300: const Color(0xFF870A4F),
                  400: const Color(0xFF870A4F),
                  500: const Color(0xFF870A4F),
                  600: const Color(0xFF870A4F),
                  700: const Color(0xFF870A4F),
                  800: const Color(0xFF870A4F),
                  900: const Color(0xFF870A4F),
                },
              );
              return Theme(
                  data: ThemeData(
                    primarySwatch: buttonTextColor,
                    primaryColor: Styles.complementaryColor,
                    buttonBarTheme: ButtonBarThemeData(
                      buttonTextTheme: ButtonTextTheme.accent,
                    ),
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: Styles.complementaryColor),
                  ),
                  child: Center(
                      child: Container(
                    constraints: BoxConstraints(
                      maxHeight: Responsive.isMobile(context)
                          ? _height * 0.95
                          : _height * 0.7,
                      maxWidth: Responsive.isMobile(context)
                          ? _width * 0.95
                          : _width * 0.3,
                    ),
                    child: child!,
                  )));
            },
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
