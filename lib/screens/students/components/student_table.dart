import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/custom_switch.dart';
import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/student.controller.dart';
import 'package:clock_in_admin/models/student.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/students/add_student_dialog.dart';
import 'package:clock_in_admin/screens/students/update_student_dialog.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_student_dialog.dart';

class StudentsTable extends StatelessWidget {
  const StudentsTable({
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
          child: Consumer<StudentController>(
            builder: (context, studentsState, child) {
              if (studentsState.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(child: Text('Something went wrong')),
                );
              }
              if (studentsState.waiting) {
                return ShimmerEffect.rectangular(height: 500);
              }
              return PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List of students",
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
                          builder: (context) => AddStudentDialog(),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New Student"),
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
                    label: Text('Student Id'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Course'),
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
                source: DataSource(studentsState.getFilteredStudents, context),
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
    Student student = Student.fromMapObject(docSnapshot.data());
    bool selected = false;
    return DataRow.byIndex(
      selected: selected,
      index: index,
      cells: <DataCell>[
        // DataCell(Image.network(farmer.picture)),
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
                        student.gender!.toLowerCase() == 'male'
                            ? 'assets/images/student_male-no-bg.png'
                            : 'assets/images/student-female-no-bg.png',
                      ),
                    ),
              alignment: Alignment.center,
            ),
          ),
        ),
        DataCell(
          Text(
            student.id!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(student.fullName()!)),
        DataCell(Text(student.course!)),
        DataCell(Text(student.residence!)),
        DataCell(Text(student.gender!.toUpperCase())),
        DataCell(
          CustomSwitch(
            isSwitched: student.enabled ?? false,
            onChanged: (value) async {
              Map<String, dynamic> update = {'enabled': value};
              await FirestoreDB.updateDoc('students', student.id, update);
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
                      return ViewStudentDialog(
                        student: student,
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
                      return UpdateStudentDialog(
                        student: student,
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
                              if (student.enabled != true) {
                                await FirestoreDB.deleteDoc(
                                  'students',
                                  student.id,
                                );

                                // creates the collection reference of the student log
                                final CollectionReference studentClocks =
                                    FirebaseFirestore.instance
                                        .collection('student_clocks');

                                // Get the student  attendance log datafrom the databse using the old staffID
                                var snapshot = await studentClocks
                                    .where('studentId', isEqualTo: student.id)
                                    .orderBy('time', descending: true)
                                    .get();

                                if (snapshot.docs.isNotEmpty) {
                                  /// Use a batch to update all the documents that returns
                                  WriteBatch writeBatch =
                                      FirebaseFirestore.instance.batch();
                                  snapshot.docs.forEach((doc) async {
                                    var docRef = studentClocks.doc(doc.id);
                                    writeBatch.delete(docRef);
                                  });

                                  // Comit the batch operation in the database.
                                  await writeBatch.commit();
                                  print('All the docs are deleted');
                                }
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
