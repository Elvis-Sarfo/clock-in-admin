import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/custom_switch.dart';
import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/teacher.controller.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/teachers/update_teacher_dialog.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_teacher_dialog.dart';
import '../view_teacher_dialog.dart';

class TeachersTable extends StatelessWidget {
  const TeachersTable({
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
          child: Consumer<TeacherController>(
            builder: (context, teachersState, child) {
              if (teachersState.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(child: Text('Something went wrong')),
                );
              }
              if (teachersState.waiting) {
                return ShimmerEffect.rectangular(height: 500);
              }
              return PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List of teachers",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Styles.complementaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: Styles.defaultPadding * 1.5,
                          vertical: Styles.defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddTeacherDialog(),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New Teacher"),
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
                source: DataSource(teachersState.getFilteredTeachers, context),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataSource extends DataTableSource {
  List? asyncSnapshot;
  BuildContext? context;
  // Constructor
  DataSource(this.asyncSnapshot, this.context);

  setList(List list) {
    asyncSnapshot = list;
  }

  // Start Overides
  @override
  DataRow getRow(int index) {
    var docSnapshot = asyncSnapshot![index];
    Teacher teacher = Teacher.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      // color: MaterialStateProperty.resolveWith<Color>(
      //   (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.selected))
      //       return Theme.of(context!).colorScheme.primary.withOpacity(0.08);
      //     return Styles.primaryColor; // Use the default value.
      //   },
      // ),
      selected: selected,
      // onSelectChanged: (value) {
      //   selected = value;
      //   // showDialog(
      //   //   context: context,
      //   //   builder: (BuildContext context) {
      //   //     return ViewFarmer(
      //   //       farmer: farmer,
      //   //       farmerId: docSnapshot.id,
      //   //     );
      //   //   },
      //   // );
      // },
      index: index,
      cells: <DataCell>[
        // DataCell(Image.network(farmer.picture)),
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
        DataCell(
          Text(
            teacher.staffId!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(teacher.fullName()!)),
        DataCell(Text(teacher.phone!)),
        DataCell(Text(teacher.residence!)),
        DataCell(Text(teacher.gender!.toUpperCase())),
        DataCell(
          CustomSwitch(
            isSwitched: teacher.enabled ?? false,
            onChanged: (value) async {
              Map<String, dynamic> update = {'enabled': value};
              await FirestoreDB.updateDoc('teachers', teacher.staffId, update);
            },
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
                      return ViewTeacherDialog(
                        teacher: teacher,
                      );
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
                  showDialog(
                    context: context!,
                    builder: (BuildContext context) {
                      return UpdateTeacherDialog(
                        teacher: teacher,
                      );
                    },
                  );
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
                            onPressed: () async {
                              // deleteFarmer(docSnapshot.id);
                              if (teacher.enabled != true) {
                                await FirestoreDB.deleteDoc(
                                    'teachers', teacher.staffId);
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Yes, Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green,
                              ),
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
                              'No, Cancel',
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
  int get rowCount => asyncSnapshot!.length;

  @override
  int get selectedRowCount => 0;
}
