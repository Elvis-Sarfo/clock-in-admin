import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/student.controller.dart';
import 'package:clock_in_admin/models/student.dart';
import 'package:clock_in_admin/models/student_attendance.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_student_attendance_dialog.dart';

class StudentsAttendancesTable extends StatelessWidget {
  final int rowsPerPage;
  final String title;
  final bool showActions, isTabbed;
  const StudentsAttendancesTable({
    this.rowsPerPage = 7,
    this.showActions = true,
    this.isTabbed = true,
    this.title = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTabbed ? 0 : Styles.defaultPadding,
        vertical: 0,
      ),
      decoration: isTabbed ? Styles.tabCardDecoration : Styles.cardDecoration,
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
          child: Consumer<StudentController>(
            builder: (context, attendanceState, child) {
              if (attendanceState.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(child: Text('Something went wrong')),
                );
              }
              if (attendanceState.waiting) {
                return ShimmerEffect.rectangular(height: 480);
              }
              return PaginatedDataTable(
                header: (title.isNotEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            this.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      )
                    : null,
                onSelectAll: (b) {},
                rowsPerPage: this.rowsPerPage,
                horizontalMargin: 5,
                columnSpacing: 5,
                columns: <DataColumn>[
                  if (showActions)
                    DataColumn(
                      label: Text(
                        'Action',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  DataColumn(
                    label: Text(''),
                  ),
                  DataColumn(
                    label: Text(
                      'Staff Id',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Attendance Log',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
                source: DataSource(
                    attendanceState.getStudentsAttendance, context,
                    options: {'showActions': showActions}),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataSource extends DataTableSource {
  Map<String, dynamic>? iterable, options;
  BuildContext? context;
  // Constructor
  DataSource(this.iterable, this.context, {this.options});

  Widget _buildAttendanceLogWidget(List clocks) {
    clocks.sort((a, b) {
      return b['time'].compareTo(a['time']);
    });
    return clocks.length > 0
        ? Row(
            children: List.generate(
              clocks.length > 3 ? 4 : clocks.length,
              (index) {
                StudentAttendance attendance =
                    StudentAttendance.fromMapObject(clocks[index]);
                if (index == 3) {
                  return FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade300,
                          border: Border.all(color: Colors.black45, width: 1)),
                      child: Text(
                        '+${clocks.length - 3}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                  );
                }
                return _attendanceLogContainer(index, attendance);
              },
            ),
          )
        : Text('Not Reported',
            style: const TextStyle(fontSize: 18.0, color: Colors.red));
  }

  _attendanceLogContainer(int index, StudentAttendance attendance) {
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
                          color: Colors.black54),
                    ),
                  Text(
                    Utils.convertMillSecsToDateString(attendance.time!),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
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
    Student? student = Student.fromMapObject(item['details']);
    late Widget? attendanceLog = _buildAttendanceLogWidget(item['clocks']);

    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
        if (this.options?['showActions'])
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
                    return ViewStudentAttendanceDialog(
                      student: student,
                    );
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
              child: student.picture != null
                  ? CircularImage(
                      child: Image.network(student.picture!),
                    )
                  : CircularImage(
                      child: Image.asset(
                        student.gender?.toLowerCase() == 'male'
                            ? 'assets/images/student_male-no-bg.png'
                            : 'assets/images/student-female-no-bg.png',
                      ),
                    ),
              alignment: Alignment.center,
            ),
          ),
        ),
        // DataCell(Text('images')),
        DataCell(Text(student.id ?? '',
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(student.fullName() ?? '')),
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
