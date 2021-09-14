import 'package:clock_in_admin/components/attendance_charts/attendance_charts.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'components/teachers_attendance_table.dart';
import 'components/teachers_attendance_screen_meta_info.dart';

class TeachersAttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          children: [
            SizedBox(height: Styles.defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // Table to display the list of teachers in a table
                      // This widget will be in the tree always
                      TeachersAttendancesTable(
                        title: 'Teacher Atendace Log for Today',
                      ),
                      // Leave a space between the table and the next widget if the screen is in mobile mode or size
                      if (Responsive.isMobile(context))
                        SizedBox(height: Styles.defaultPadding),
                      // Add the MetaInfo widget to the column if the device is a mobile
                      if (Responsive.isMobile(context)) AttendanceChart(),
                    ],
                  ),
                ),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  SizedBox(width: Styles.defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: AttendanceChart(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
