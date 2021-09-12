import 'dart:async';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherAttendanceController extends ChangeNotifier {
  final BuildContext? context;
  final String collectionName = 'teacher_clocks';
  Map<String, dynamic> _attendance = {}, _filteredAttendance = {};
  StreamSubscription? _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  TeacherAttendanceController({this.context}) {
    streamTeachersAttendanceData();
  }

  Map<String, dynamic> get getTeachersAttendance => _attendance;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  streamTeachersAttendanceData() async {
    var now = DateTime.now();
    var lastMidnight =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    // Consumer(builder: builder)
    // var _teachers = context!.read<TeacherController>().streamTeachersData();
    // var __teachers = context!.watch<TeacherController>().streamTeachersData();
    // var _teacherss = context!.read()<TeacherController>().getFilteredTeachers;

    // var tc = TeacherController();
    // var _t = Provider.of<TeacherController>(context!, listen: false)
    //     .getFilteredTeachers;

    // Get teacher in the database
    var _teachersSnap = await FirestoreDB.getAll('teachers');
    var _teachers = _teachersSnap.docs.toList();

    _subscription = FirebaseFirestore.instance
        .collection(collectionName)
        .where('time', isGreaterThanOrEqualTo: lastMidnight)
        // .orderBy('teacherId')
        // .orderBy('time')
        .snapshots()
        .listen(
      (data) async {
        var _data = data.docs.toList();
        Map<String, dynamic> at = Map();

        var _maxIterations =
            _teachers.length > _data.length ? _teachers.length : _data.length;

        for (var i = 0; i < _maxIterations; i++) {
          var att, _key;

          if (_data.length > i) {
            att = _data[i].data();
            _key = att!['teacherId'];
          }

          if (_teachers.length > i && !at.containsKey(_teachers[i].id)) {
            at[_teachers[i].id] = {
              'details': _teachers[i].data(),
              'clocks': []
            };
          } else if (_teachers.length > i && at.containsKey(_teachers[i].id)) {
            at[_teachers[i].id]['details'] = _teachers[i].data();
          }

          if (att != null && !at.containsKey(_key)) {
            at[_key] = {
              'details': <String, dynamic>{},
              'clocks': [att]
            };
          } else if (att != null && at.containsKey(_key)) {
            at[_key]['clocks'].add(att);
          }
        }

        print(at);
        _attendance = at;
        waiting = false;
        notifyListeners();
      },
      onError: (Object error, StackTrace stackTrace) {
        hasError = true;
        notifyListeners();
      },
      onDone: () {
        done = true;
        notifyListeners();
      },
    );
  }

  void _unsubscribe() {
    _subscription!.cancel();
  }

  // searchTeacher(String searchKey) {
  //   _filteredAttendance = _attendance.where((docSnapshot) {
  //     // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
  //     // return false;
  //     Teacher teacher = Teacher.fromMapObject(docSnapshot.data()!);
  //     return teacher.staffId.toString().contains(searchKey.toLowerCase());
  //   }).toList();
  //   notifyListeners();
  // }

  // sortTeacherList(String columnName, int index, bool sorted) {
  //   sortColumnIndex = index;
  //   if (sortAscending) {
  //     sortAscending = false;
  //     _filteredAttendance.sort((a, b) {
  //       Teacher farmer1 = Teacher.fromMapObject(a.data()!);
  //       Teacher farmer2 = Teacher.fromMapObject(b.data()!);
  //       return farmer1
  //           .toMap()[columnName]
  //           .compareTo(farmer2.toMap()[columnName]);
  //     });
  //   } else {
  //     sortAscending = true;
  //     _filteredAttendance.sort((a, b) {
  //       Teacher farmer1 = Teacher.fromMapObject(a.data()!);
  //       Teacher farmer2 = Teacher.fromMapObject(b.data()!);
  //       return farmer2
  //           .toMap()[columnName]
  //           .compareTo(farmer1.toMap()[columnName]);
  //     });
  //   }
  //   notifyListeners();
  // }
}
