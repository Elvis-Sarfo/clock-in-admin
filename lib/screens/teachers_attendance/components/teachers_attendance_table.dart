import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/teacher.controller.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/models/teacher_attendance.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_teacher_attendance_dialog.dart';

class TeachersAttendancesTable extends StatelessWidget {
  final int rowsPerPage;
  final String title;
  final bool showActions, isTabbed;
  const TeachersAttendancesTable({
    this.rowsPerPage = 7,
    this.showActions = true,
    this.isTabbed = false,
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
          child: Consumer<TeacherController>(
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
                          // ElevatedButton.icon(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.symmetric(
                          //       horizontal: Styles.defaultPadding * 1.5,
                          //       vertical: Styles.defaultPadding /
                          //           (Responsive.isMobile(context) ? 2 : 1),
                          //     ),
                          //   ),
                          //   onPressed: () {},
                          //   icon: Icon(Icons.add),
                          //   label: Text("Add A Search"),
                          // ),
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
                    attendanceState.getTeachersAttendance, context,
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
                TeacherAttendance attendance =
                    TeacherAttendance.fromMapObject(clocks[index]);
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
    // SizedBox(
    //     width: 250.0,
    //     child: DefaultTextStyle(
    //       style: const TextStyle(fontSize: 18.0, color: Colors.red),
    //       child: AnimatedTextKit(
    //         repeatForever: true,
    //         animatedTexts: [
    //           ScaleAnimatedText(
    //             'Not Reported',
    //             duration: const Duration(milliseconds: 1000),
    //             scalingFactor: 0.7,
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
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
    Teacher? teacher = Teacher.fromMapObject(item['details']);
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
                    return ViewTeacherAttendanceDialog(
                      teacher: teacher,
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
