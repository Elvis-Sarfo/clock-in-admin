import 'package:clock_in_admin/models/teacher_attendance.dart';
import 'package:clock_in_admin/utils/utils.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceLog extends StatelessWidget {
  // var teacherId;
  final Map? clockLog;

  AttendanceLog({
    Key? key,
    this.clockLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: clockLog!.length + 1,
        itemBuilder: (context, index) {
          if (index == clockLog!.length) {
            return SizedBox(height: 60);
          } else {
            var _key = clockLog!.keys.toList()[index];
            var item = clockLog![_key];

            // Teacher? teacher = Teacher.fromMapObject(item['details']);
            // late Widget? attendanceLog = _buildAttendanceLogWidget(item['clocks']);
            return ExpandableListItem(
              clocks: item,
              dateString: _key,
            );
          }
        },
      ),
    );
  }
}

class ExpandableListItem extends StatelessWidget {
  final String? dateString;
  final List? clocks;

  ExpandableListItem({
    this.clocks,
    Key? key,
    this.dateString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('dd-MMM-yyyy').parse(dateString!);
    var _day = DateFormat('EEEE').format(date);
    TeacherAttendance? latestClock =
        clocks!.length > 0 ? TeacherAttendance.fromMapObject(clocks![0]) : null;

    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: latestClock != null
                  ? latestClock.type == 'in'
                      ? Colors.green
                      : Colors.grey
                  : Colors.red,
              width: 0.5),
          borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0.0,
      child: ExpansionTileCard(
        elevation: 0.0,
        duration: Duration(milliseconds: 0),
        borderRadius: BorderRadius.circular(8.0),
        title: ListTile(
          contentPadding: EdgeInsets.only(
            right: 0.0,
            left: 20.0,
            top: 0.0,
            bottom: 0.0,
          ),
          title: Text(
            dateString!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('$_day'),
          trailing: Container(
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
                color: latestClock != null
                    // ? latestClock.type == 'in'
                    ? Colors.green
                    // : Styles.complementaryColor
                    : Colors.red,
                borderRadius: BorderRadius.circular(20.0)),
            child: Icon(
              latestClock != null
                  ? Icons.local_parking_outlined
                  : Icons.hdr_auto_outlined,
              color: Colors.white,
              size: 12.0,
            ),
          ),
        ),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 40.0, 10.0),
            child: Column(
              children: clocks!.map((e) {
                TeacherAttendance clock = TeacherAttendance.fromMapObject(e);
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 0.5, color: Colors.grey))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(clock.type == 'in'
                                ? Icons.arrow_forward
                                : Icons.arrow_back),
                            SizedBox(height: 2),
                            Text(
                              clock.type == 'in' ? 'IN' : 'OUT',
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                Utils.convertMillSecsToDateString(clock.time!)),
                            SizedBox(height: 5),
                            Text(
                              'Greenwich Standard Time',
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.person),
                      Icon(Icons.room_outlined)
                    ],
                  ),
                );
              }).toList(),

              // List.generate(
              // 1,
              // (index) => Container(
              //   padding: EdgeInsets.symmetric(vertical: 5.0),
              //   decoration: BoxDecoration(
              //       border: Border(
              //           bottom: BorderSide(width: 0.5, color: Colors.grey))),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Column(
              //           children: [
              //             Icon(type == 'in'
              //                 ? Icons.arrow_forward
              //                 : Icons.arrow_back),
              //             SizedBox(height: 2),
              //             Text(
              //               type == 'in' ? 'IN' : 'OUT',
              //             )
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 20),
              //       Expanded(
              //         flex: 5,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('$_time'),
              //             SizedBox(height: 5),
              //             Text(
              //               'Greenwich Standard Time',
              //             )
              //           ],
              //         ),
              //       ),
              //       Spacer(),
              //       Icon(Icons.person),
              //       Icon(Icons.room_outlined)
              //     ],
              //   ),
              // ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
