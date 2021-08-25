import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/custom_switch.dart';
import 'package:clock_in_admin/controllers/teacher_attendance.controller.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/models/teacher_attendance.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
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
                    label: Text(''),
                  ),
                  DataColumn(
                    label: Text('Staff Id'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Phone'),
                  ),
                  DataColumn(
                    label: Text('Location'),
                  ),
                  DataColumn(
                    label: Text('Gender'),
                  ),
                  DataColumn(label: Text('Enabled')),
                  DataColumn(
                      label: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                  )),
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
  Map<String, dynamic> iterable;
  BuildContext? context;
  // Constructor
  DataSource(this.iterable, this.context);

  // Start Overides
  @override
  DataRow getRow(int index) {
    var _key = iterable.keys.toList()[index];
    var item = iterable[_key];
    Teacher teacher = Teacher.fromMapObject(item['details']);
    TeacherAttendance? attendance = item['clocks']!.length > 0
        ? TeacherAttendance.fromMapObject(item['clocks'][0])
        : null;

    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
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
                        teacher.gender!.toLowerCase() == 'male'
                            ? 'assets/images/teacher_male-no-bg.png'
                            : 'assets/images/teacher-female-no-bg.png',
                      ),
                    ),
              alignment: Alignment.center,
            ),
          ),
        ),
        // DataCell(Text('images')),
        DataCell(Text(teacher.staffId!,
            style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(teacher.fullName()!)),
        DataCell(Text(attendance?.type ?? '')),
        DataCell(Text(attendance?.type ?? '')),
        DataCell(Text(attendance?.time != null
            ? DateTime.fromMillisecondsSinceEpoch(attendance!.time!)
                .hour
                .toString()
            : '')),
        DataCell(
          CustomSwitch(
            isSwitched: false,
            onChanged: (value) async {},
          ),
        ),
        DataCell(
          Row(
            children: [
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
              IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.edit,
                  color: Styles.secondaryColor,
                ),
                tooltip: 'Edit',
                onPressed: () {
                  // showDialog(
                  //   context: context!,
                  //   builder: (BuildContext context) {
                  //     return UpdateFarmer(
                  //       farmer: farmer,
                  //       farmerDocSnap: docSnapshot,
                  //     );
                  //   },
                  // );
                },
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                tooltip: 'Delete',
                onPressed: () {
                  showDialog(
                    context: context!,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Are you sure you want to delete?',
                        descriptions: 'This action cannot be undone!',
                        dialogIcon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 70,
                        ),
                        actionsButtons: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            onPressed: () {
                              // deleteFarmer(docSnapshot.id);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Styles.primaryColor),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => iterable.length;

  @override
  int get selectedRowCount => 0;
}
