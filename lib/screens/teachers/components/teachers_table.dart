import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/custom_switch.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
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
          child: PaginatedDataTable(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "List of teachers",
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
            source: DataSource([], context),
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
        // DataCell(
        // Align(
        //   child: farmer.picture != null
        //       ? CircularImage(
        //           child: Image.network(farmer.picture),
        //         )
        //       : CircularImage(
        //           child: null,
        //         ),
        //   alignment: Alignment.center,
        // ),
        // ),
        DataCell(Text('DATA')),
        DataCell(Text('.name')),
        DataCell(Text('.phone')),
        DataCell(Text('.location')),
        DataCell(Text('Male')),
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
                      return ViewTeacherDialog();
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
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
