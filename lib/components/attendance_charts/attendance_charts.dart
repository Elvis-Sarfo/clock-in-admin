import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/teacher_attendance.controller.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/chart.dart';
import 'components/chart_card.dart';

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<TeacherAttendanceController>(
          builder: (context, attendanceState, child) {
            if (attendanceState.hasError) {
              return Padding(
                padding: const EdgeInsets.all(100.0),
                child: Center(child: Text('Error loading chart')),
              );
            }
            if (attendanceState.waiting) {
              return ShimmerEffect.rectangular(height: 270);
            }
            return ChartCard(
              title: 'Teachers Attendance Chart',
              child: Chart(
                total: attendanceState.totalNumOfTeachers,
                value: attendanceState.numOfPresentTeachers,
                sections: [
                  if (attendanceState.numOfPresentTeachers > 0)
                    PieChartSectionData(
                      color: Color(0xFFFFCF26),
                      value: attendanceState.numOfPresentTeachers.toDouble(),
                      showTitle: false,
                      radius: 19,
                      title: 'Present',
                    ),
                  if (attendanceState.numOfAbsentTeachers > 0)
                    PieChartSectionData(
                      color: Color(0xFFEE2727),
                      value: attendanceState.numOfAbsentTeachers.toDouble(),
                      showTitle: false,
                      radius: 16,
                      title: 'Absent',
                    ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: Styles.defaultPadding),
        // StarageDetails(),
      ],
    );
  }
}
