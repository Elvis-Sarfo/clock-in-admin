import 'package:clock_in_admin/components/card_view.dart';
import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/custom_date_range_picker.dart';
import 'package:clock_in_admin/models/student.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/attendance_log.dart';

class ViewStudentAttendanceDialog extends StatefulWidget {
  final Student? student;
  ViewStudentAttendanceDialog({Key? key, this.student}) : super(key: key);

  @override
  State<ViewStudentAttendanceDialog> createState() =>
      _ViewStudentAttendanceDialogState();
}

class _ViewStudentAttendanceDialogState
    extends State<ViewStudentAttendanceDialog> {
  final CollectionReference studentClocks =
      FirebaseFirestore.instance.collection('student_clocks');

  DateTime? _startDate, _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // final _pickDateRange = context.watch<DateRangePicker>();
    // DateTimeRange _dateRange =
    //     DateTimeRange(start: DateTime.now(), end: DateTime.now());

    return Scaffold(
      backgroundColor: Colors.transparent,
      // primary: false,

      body: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.all(20),
          color: Styles.backgroundColor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('StudentAttendance Details'),
                  Tooltip(
                    message: "Close Window",
                    child: IconButton(
                        splashColor: Colors.red.withOpacity(0.3),
                        hoverColor: Colors.red.withOpacity(0.3),
                        splashRadius: 20,
                        highlightColor: Colors.white,
                        icon: Icon(
                          Icons.close,
                          color: Colors.redAccent,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
              _buildUserProfileWidget(context, widget.student!),
              Card(
                elevation: 1.0,
                child: CustomDateRangePicker(
                  onChanged: (value) {
                    setState(() {
                      _startDate = value!.start;
                      _endDate = value.end;
                    });
                  },
                ),
              ),
              // buildSummaryWidget(context, _pickDateRange),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: studentClocks
                      .where('studentId', isEqualTo: widget.student!.id)
                      .orderBy('time', descending: true)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      Map<String, dynamic> _clockLog = {};
                      var _attendance = snapshot.data!.docs;
                      int counter = 0;
                      var _date;

                      var now = DateTime.now();

                      var endDate = DateTime(
                        _endDate!.year,
                        _endDate!.month,
                        _endDate!.day,
                      );

                      DateTime startDate = _startDate == null
                          ? DateTime(
                              now.year,
                              now.month,
                              now.day,
                            ).subtract(Duration(days: now.day - 1))
                          : DateTime(
                              _startDate!.year,
                              _startDate!.month,
                              _startDate!.day,
                            );

                      var timeTrack = endDate.add(Duration(days: 1));
                      // Structure the data
                      while (counter < 32 || counter < _attendance.length) {
                        timeTrack = timeTrack.subtract(Duration(days: 1));
                        _date = DateFormat('dd-MMM-yyyy').format(timeTrack);

                        bool _isValidDay = timeTrack.isAfter(
                          startDate.subtract(
                            Duration(days: 1),
                          ),
                        );

                        if (!_clockLog.containsKey(_date) && _isValidDay) {
                          _clockLog[_date] = [];
                        }

                        if (counter < _attendance.length) {
                          var _data = _attendance[counter];
                          var _time = DateTime.fromMillisecondsSinceEpoch(
                              _data.data()['time']);

                          var _formattedTime =
                              DateFormat('dd-MMM-yyyy').format(_time);

                          _time = DateTime(
                            _time.year,
                            _time.month,
                            _time.day,
                          );

                          var __startDate =
                              startDate.subtract(Duration(days: 1));
                          var __endDate = endDate.add(Duration(days: 1));

                          bool isValidDate = _time.isAfter(__startDate) &&
                              _time.isBefore(__endDate);

                          if (!_clockLog.containsKey(_formattedTime) &&
                              isValidDate) {
                            _clockLog[_formattedTime] = [_data.data()];
                          } else if (isValidDate) {
                            _clockLog[_formattedTime].add(_data.data());
                          }
                        }

                        ++counter;
                      }
                      return AttendanceLog(
                        clockLog: _clockLog,
                      );
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        )
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getFirstDateOfMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.day - 1));
  }

  bool isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  _buildUserProfileWidget(BuildContext context, Student student) {
    return CardView(
      elevation: 0.0,
      child: ListTile(
        leading: student.picture != null
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
        title: Text(student.fullName() ?? ''),
      ),
    );
  }
}
