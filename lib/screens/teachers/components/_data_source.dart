// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farmasyst_admin_console/components/circular_image.dart';
// import 'package:farmasyst_admin_console/components/custom_alert_dailog.dart';
// import 'package:farmasyst_admin_console/components/custom_switch.dart';
// import 'package:farmasyst_admin_console/models/farmer.dart';
// import 'package:farmasyst_admin_console/screens/farmers/components/famer_module.dart';
// import 'package:farmasyst_admin_console/screens/farmers/update_farmer.dart';
// import 'package:farmasyst_admin_console/screens/farmers/view_farmer.dart';
// import 'package:farmasyst_admin_console/services/constants.dart';
// import 'package:farmasyst_admin_console/services/database_services.dart';
// import 'package:flutter/material.dart';

// class FarmerDataSource extends DataTableSource {
//   List asyncSnapshot;
//   BuildContext context;
//   // Constructor
//   FarmerDataSource(this.asyncSnapshot, this.context);

//   setList(List list) {
//     asyncSnapshot = list;
//   }

//   // Start Overides
//   @override
//   DataRow getRow(int index) {
//     var docSnapshot = asyncSnapshot[index];
//     Farmer farmer = Farmer.fromMapObject(docSnapshot.data());
//     bool selected = false;
//     return DataRow.byIndex(
//       selected: selected,
//       // onSelectChanged: (value) {
//       //   selected = value;
//       //   // showDialog(
//       //   //   context: context,
//       //   //   builder: (BuildContext context) {
//       //   //     return ViewFarmer(
//       //   //       farmer: farmer,
//       //   //       farmerId: docSnapshot.id,
//       //   //     );
//       //   //   },
//       //   // );
//       // },
//       index: index,
//       cells: <DataCell>[
//         // DataCell(Image.network(farmer.picture)),
//         DataCell(Align(
//           child: farmer.picture != null
//               ? CircularImage(
//                   child: Image.network(farmer.picture),
//                 )
//               : CircularImage(
//                   child: null,
//                 ),
//           alignment: Alignment.center,
//         )),
//         DataCell(Text(farmer.name)),
//         DataCell(Text(farmer.phone)),
//         DataCell(Text(farmer.location)),
//         DataCell(Text(farmer.gender.toUpperCase())),
//         DataCell(
//           CustomSwitch(
//             isSwitched: farmer.enabled,
//             onChanged: (value) async {
//               Map<String, dynamic> update = {'enabled': value};
//               await DatabaseServices.updateDocument(
//                 'Farmers',
//                 docSnapshot.id,
//                 update,
//               );
//             },
//           ),
//         ),
//         DataCell(
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.remove_red_eye,
//                   color: kPrimaryColor,
//                 ),
//                 tooltip: 'View',
//                 splashRadius: 20,
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return ViewFarmer(
//                         farmer: farmer,
//                         farmerId: docSnapshot.id,
//                       );
//                     },
//                   );
//                 },
//               ),
//               IconButton(
//                 splashRadius: 20,
//                 icon: const Icon(
//                   Icons.edit,
//                   color: kSecondaryColor,
//                 ),
//                 tooltip: 'Edit',
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return UpdateFarmer(
//                         farmer: farmer,
//                         farmerDocSnap: docSnapshot,
//                       );
//                     },
//                   );
//                 },
//               ),
//               IconButton(
//                 splashRadius: 20,
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//                 tooltip: 'Delete',
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CustomAlertDialog(
//                         title: 'Are you sure you want to delete?',
//                         descriptions: 'This action cannot be undone!',
//                         dialogIcon: Icon(
//                           Icons.delete_forever,
//                           color: Colors.red,
//                           size: 70,
//                         ),
//                         actionsButtons: [
//                           TextButton(
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStateProperty.all<Color>(Colors.red),
//                               padding: MaterialStateProperty.all(
//                                 EdgeInsets.symmetric(
//                                   horizontal: 15,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               deleteFarmer(docSnapshot.id);
//                               Navigator.of(context).pop();
//                             },
//                             child: Text(
//                               'Delete',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                             ),
//                           ),
//                           TextButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   kPrimaryColor),
//                               padding: MaterialStateProperty.all(
//                                 EdgeInsets.symmetric(
//                                   horizontal: 15,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => asyncSnapshot.length;

//   @override
//   int get selectedRowCount => 0;
// }
