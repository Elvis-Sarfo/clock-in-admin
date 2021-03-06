import 'package:clock_in_admin/components/attendance_charts/attendance_charts.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/teachers_attendance/components/teachers_attendance_table.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'components/dashboard_info.dart';

class DashboardScreen extends StatelessWidget {
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
                      DashboardInfo(),
                      SizedBox(height: Styles.defaultPadding),

                      // Table to display the list of teachers in a table
                      // This widget will be in the tree always
                      TeachersAttendancesTable(
                        rowsPerPage: 5,
                        title: 'Teacher Atendace Log for Today',
                        showActions: false,
                      ),
                      if (Responsive.isMobile(context))
                        SizedBox(height: Styles.defaultPadding),
                      if (Responsive.isMobile(context)) AttendanceChart(),
                    ],
                  ),
                ),
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
