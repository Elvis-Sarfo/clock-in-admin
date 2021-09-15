// import 'package:clock_in_admin/components/custom_date_range_picker.dart';
// import 'package:clock_in_admin/controllers/date_picker.dart';
// import 'package:clock_in_admin/controllers/teacher_attendance.controller.dart';
// import 'package:clock_in_admin/screens/teachers_attendance/components/attendance_log.dart';
// import 'package:clock_in_admin/services/sharedPrefs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';

// class TimeTracker extends StatefulWidget {
//   final Map clockLog;
//   TimeTracker({this.clockLog = const {}});
//   @override
//   _TimeTrackerState createState() => _TimeTrackerState();
// }

// class _TimeTrackerState extends State<TimeTracker> {
//   final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //  var _pickDateRange = Provider.of<DateRangePicker>(context, listen: true);
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<DateRangePicker>(
//           create: (context) => DateRangePicker(context: context),
//         ),
//       ],
//       builder: (context, child) {
//         final _pickDateRange = context.watch<DateRangePicker>();
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // _buildUserProfileWidget(context, _userName!),
//             Card(
//               elevation: 1.0,
//               child: InkWell(
//                 onTap: () async => await _pickDateRange.pickDateRange(),
//                 child: CustomDateRangePicker(
//                   pickDateRange: _pickDateRange,
//                 ),
//               ),
//             ),
//             // buildSummaryWidget(context, _pickDateRange),
//             Expanded(
//               child: AttendanceLog(
//                 clockLog: widget.clockLog,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // _buildUserProfileWidget(BuildContext context, String _userName) {
//   //   return CardView(
//   //     elevation: 0.0,
//   //     child: ListTile(
//   //       leading: CircleAvatar(
//   //         radius: 30.0,
//   //         backgroundColor: Colors.blueGrey,
//   //         backgroundImage: AssetImage(Constant.USER_PROFILE),
//   //         onBackgroundImageError: (exception, stackTrace) => CircleAvatar(),
//   //       ),
//   //       title: Text(_userName),
//   //     ),
//   //   );
//   // }

//   // _buildHeader(int index) {
//   //   return ListTile(
//   //     contentPadding: EdgeInsets.only(
//   //       right: 0.0,
//   //       left: 20.0,
//   //     ),
//   //     title: Text('27-May-2021'),
//   //     subtitle: Text('Thursday'),
//   //     trailing: Container(
//   //       height: 20.0,
//   //       width: 20.0,
//   //       decoration: BoxDecoration(
//   //           color: index != 1 ? Colors.green : Colors.red,
//   //           borderRadius: BorderRadius.circular(20.0)),
//   //       child: Icon(
//   //         index != 1 ? Icons.check_outlined : Icons.close,
//   //         color: Colors.white,
//   //         size: 12.0,
//   //       ),
//   //     ),
//   //   );
//   // }

//   // _buildBody() {
//   //   return Container(
//   //       margin: EdgeInsets.fromLTRB(20.0, 0.0, 40.0, 10.0),
//   //       child: Column(
//   //         children: [
//   //           ...List.generate(
//   //             5,
//   //             (index) => Container(
//   //               padding: EdgeInsets.symmetric(vertical: 5.0),
//   //               decoration: BoxDecoration(
//   //                   border: Border(
//   //                       bottom: BorderSide(width: 0.5, color: Colors.grey))),
//   //               child: Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: Column(
//   //                       children: [
//   //                         Icon(Icons.arrow_forward),
//   //                         sizedBoxSpace(height: 5),
//   //                         Text(
//   //                           'IN',
//   //                         )
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   sizedBoxSpace(width: 30),
//   //                   Expanded(
//   //                     flex: 5,
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text('12:05:59 PM'),
//   //                         sizedBoxSpace(height: 10),
//   //                         Text(
//   //                           'Greenwich Standard Time',
//   //                         )
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   Spacer(),
//   //                   Icon(Icons.person),
//   //                   Icon(Icons.room_outlined)
//   //                 ],
//   //               ),
//   //             ),
//   //           )
//   //         ],
//   //       ));
//   // }

//   // _buildExpansionList() {
//   //   return ExpansionPanelList(
//   //     expansionCallback: (panelIndex, isExpanded) {
//   //       setState(() {
//   //         _isOpen[panelIndex] = !isExpanded;
//   //       });
//   //     },
//   //     children: [
//   //       ...List.generate(3, (index) {
//   //         _isOpen.add(false);
//   //         return ExpansionPanel(
//   //             headerBuilder: (context, isExpanded) => _buildHeader(index),
//   //             body: _buildBody(),
//   //             isExpanded: _isOpen[index],
//   //             canTapOnHeader: true);
//   //       }),
//   //     ],
//   //   );
//   // }

//   // _expand() {
//   //   return ExpansionTileCard(
//   //     key: cardB,
//   //     leading: Container(
//   //       height: 20.0,
//   //       width: 20.0,
//   //       decoration: BoxDecoration(
//   //           color: Colors.green, borderRadius: BorderRadius.circular(60.0)),
//   //       child: Icon(
//   //         Icons.check_outlined,
//   //         color: Colors.white,
//   //         size: 15.0,
//   //       ),
//   //     ),
//   //     title: Text('27-May-2021'),
//   //     subtitle: Text('Thursday'),
//   //     children: [
//   //       ...List.generate(
//   //         3,
//   //         (index) => Container(
//   //           padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
//   //           decoration: BoxDecoration(
//   //               border:
//   //                   Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
//   //           child: Row(
//   //             children: [
//   //               Expanded(
//   //                 child: Column(
//   //                   children: [
//   //                     Icon(Icons.arrow_forward),
//   //                     SizedBox(height: 2),
//   //                     Text(
//   //                       index != 1 ? 'IN' : 'OUT',
//   //                     )
//   //                   ],
//   //                 ),
//   //               ),
//   //               SizedBox(width: 30),
//   //               Expanded(
//   //                 flex: 5,
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text('12:05:59 PM'),
//   //                     SizedBox(height: 6),
//   //                     Text(
//   //                       'Greenwich Standard Time',
//   //                     )
//   //                   ],
//   //                 ),
//   //               ),
//   //               Spacer(),
//   //               Icon(Icons.person),
//   //               Icon(Icons.room_outlined)
//   //             ],
//   //           ),
//   //         ),
//   //       )
//   //     ],
//   //   );
//   // }

// }
