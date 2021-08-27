import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/custom_switch.dart';
import 'package:clock_in_admin/controllers/teacher_attendance.controller.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/models/teacher_attendance.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/main/main_screen.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_teacher_attendance_dialog.dart';

class TeachersAttendancesTable extends StatelessWidget {
  const TeachersAttendancesTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Styles.defaultPadding,
        vertical: 0,
      ),
      decoration: Styles.cardDecoration,
      child: SizedBox(
        width: double.infinity,
        child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(),
            textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black87)),
            cardTheme: CardTheme(
              color: Colors.white,
              elevation: 0.0,
              shadowColor: Colors.transparent,
            ),
          ),
          child: Consumer<TeacherAttendanceController>(
            builder: (context, attendanceState, child) {
              if (attendanceState.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(child: Text('Something went wrong')),
                );
              }
              if (attendanceState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List of Teachers Attendance for today",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: Styles.defaultPadding * 1.5,
                          vertical: Styles.defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                    ),
                  ],
                ),
                onSelectAll: (b) {},
                rowsPerPage: 7,
                horizontalMargin: 5,
                columnSpacing: 5,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Action',
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Text(''),
                  ),
                  DataColumn(
                    label: Text('Staff Id'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Attendance Log'),
                  ),
                ],
                source:
                    DataSource(attendanceState.getTeachersAttendance, context),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataSource extends DataTableSource {
  Map<String, dynamic>? iterable;
  BuildContext? context;
  // Constructor
  DataSource(this.iterable, this.context);

  Widget _buildAttendanceLogWidget(List clocks) {
    clocks.sort((a, b) {
      return b['time'].compareTo(a['time']);
    });
    return clocks.length > 0
        ? Row(
            children: List.generate(
              clocks.length > 3 ? 4 : clocks.length,
              (index) {
                TeacherAttendance attendance =
                    TeacherAttendance.fromMapObject(clocks[index]);
                if (index == 3) {
                  return SizedBox(
                    width: 50.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black45,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText('...'),
                        ],
                      ),
                    ),
                  );
                }
                return _attendanceLogContainer(index, attendance);
              },
            ),
          )
        : SizedBox(
            width: 250.0,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 18.0, color: Colors.red),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ScaleAnimatedText(
                    'Not Reported',
                    duration: const Duration(milliseconds: 1000),
                    scalingFactor: 0.7,
                  ),
                ],
              ),
            ),
          );
  }

  _attendanceLogContainer(int index, TeacherAttendance attendance) {
    var _isLatestClock = index == 0;
    var _isClockedIn = attendance.type == 'in';
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
          width: _isLatestClock ? 100 : 85,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: _isLatestClock ? 5 : 2, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              shape: BoxShape.rectangle,
              color: _isLatestClock
                  ? attendance.type == 'in'
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2)
                  : Colors.white,
              border: Border.all(
                  color: _isLatestClock
                      ? _isClockedIn
                          ? Colors.green
                          : Colors.red
                      : Colors.black45,
                  width: 1)),
          child: Row(
            children: [
              Container(
                height: _isLatestClock ? 20.0 : 16.0,
                width: _isLatestClock ? 20.0 : 16.0,
                decoration: BoxDecoration(
                    color: _isClockedIn ? Colors.green : Colors.red,
                    shape: BoxShape.circle),
                child: Icon(
                  _isClockedIn ? Icons.check : Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLatestClock)
                    Text(
                      attendance.type!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  Text(
                    Utils.convertMillSecsToDateString(attendance.time!),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  // Start Overides
  @override
  DataRow getRow(int index) {
    var _key = iterable!.keys.toList()[index];
    var item = iterable![_key];
    Teacher? teacher = Teacher.fromMapObject(item['details']);
    late Widget? attendanceLog = _buildAttendanceLogWidget(item['clocks']);

    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
        DataCell(
          IconButton(
            icon: const Icon(
              Icons.remove_red_eye,
              color: Styles.primaryColor,
            ),
            tooltip: 'View',
            splashRadius: 20,
            onPressed: () {
              showDialog(
                context: context!,
                builder: (BuildContext context) {
                  return ViewTeacherAttendanceDialog();
                },
              );
            },
          ),
        ),
        // IMAGE DATA CELL
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: teacher.picture != null
                  ? CircularImage(
                      child: Image.network(teacher.picture!),
                    )
                  : CircularImage(
                      child: Image.asset(
                        teacher.gender?.toLowerCase() == 'male'
                            ? 'assets/images/teacher_male-no-bg.png'
                            : 'assets/images/teacher-female-no-bg.png',
                      ),
                    ),
              alignment: Alignment.center,
            ),
          ),
        ),
        // DataCell(Text('images')),
        DataCell(Text(teacher.staffId ?? '',
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(teacher.fullName() ?? '')),
        DataCell(attendanceLog),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => iterable!.length;

  @override
  int get selectedRowCount => 0;
}
