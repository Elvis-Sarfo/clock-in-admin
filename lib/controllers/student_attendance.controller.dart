import 'dart:async';
import 'package:clock_in_admin/models/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum StudentControl { attendance, students }

class StudentAttendanceController extends ChangeNotifier {
  final StudentControl? studentControl;
  final BuildContext? context;
  final String collectionName = 'student_clocks';
  Map<String, dynamic> _attendance = {}, _filteredAttendance = {};
  List<QueryDocumentSnapshot> _students = [], _filteredStudents = [];
  StreamSubscription? _subscription, _subscription1;

  int sortColumnIndex = 1;
  bool waiting = true,
      hasError = false,
      done = false,
      sortAscending = true,
      isUpdatingStudent = false,
      showErrorMsg = false;

  int numOfPresentStudents = 0;
  int numOfAbsentStudents = 0;
  int numOfStudentsOnCampus = 0;
  int numOfStudentsOutCampus = 0;
  int totalNumOfStudents = 0;

  // contrusctor
  StudentAttendanceController({this.context, this.studentControl}) {
    streamStudentsAttendanceData();
  }

// Getters
  Map<String, dynamic> get getStudentsAttendance => _attendance;
  Map<String, dynamic> get getStudentsFitteredAttendance => _filteredAttendance;
  List get getStudents => _students;
  List get getFilteredStudents => _filteredStudents;

  @override
  void dispose() {
    _unsubscribe(_subscription);
    super.dispose();
  }

  streamStudentsAttendanceData() async {
    var now = DateTime.now();
    var lastMidnight =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    // Get student in the database
    // var _studentsSnap = await FirestoreDB.getAll('students');
    // var _students = _studentsSnap.docs.toList();

    // get the total number of students in the database
    // totalNumOfStudents = _students.length;

    _subscription1 =
        FirebaseFirestore.instance.collection('students').snapshots().listen(
      (_studentsSnap)
      //  {
      //   var _students = _studentsSnap.docs.toList();
      //   totalNumOfStudents = _students.length;

      //   startAttendanceStream(lastMidnight, _students);
      //   notifyListeners();
      // },
      {
        _filteredStudents = _students = _studentsSnap.docs.toList();
        totalNumOfStudents = _students.length;

        startAttendanceStream(lastMidnight, _students);

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

  void startAttendanceStream(
      int lastMidnight, List<QueryDocumentSnapshot> _students) {
    _subscription = FirebaseFirestore.instance
        .collection(collectionName)
        .where('time', isGreaterThanOrEqualTo: lastMidnight)
        // .orderBy('studentId')
        .orderBy('time')
        .snapshots()
        .listen(
      (data) async {
        var _data = data.docs.toList();
        Map<String, dynamic> at = Map();

        numOfPresentStudents = 0;
        numOfAbsentStudents = 0;
        numOfStudentsOnCampus = 0;
        numOfStudentsOutCampus = 0;

        /// Generate attendance log
        generateAttendanceLog(_students, _data, at);
        attendanceSummary(at);

        // print(at);
        _attendance = at;
        waiting = false;
        notifyListeners();

        // attendanceSummary(at);
        // notifyListeners();
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

  void generateAttendanceLog(List<dynamic> _students,
      List<QueryDocumentSnapshot> _data, Map<String, dynamic> at) {
    /// Get the maximum number of iterations to be done
    /// Thisis done by comparing the lenght of the students list and the lenght
    /// of the student attendance list then return the lenght of the greater one
    var _maxIterations =
        _students.length > _data.length ? _students.length : _data.length;

    /// The loop starts here
    for (var i = 0; i < _maxIterations; i++) {
      // The att and the _key variable will hold the current attendance data in the list
      // and the staffId respectively
      var att, _key;

      /// Check if the attendance list is greater than the loops counter before
      /// assigning values to variable
      /// This is done to make sure that we dont access undefined elements in the list
      if (_data.length > i) {
        att = _data[i].data();
        _key = att!['studentId'];
      }

      /// Check if the lennght of students list is greater than the loop counter
      /// to prevent accessing undefined items from the students list.
      /// Again, check if the final Map does not contain the key already
      if (_students.length > i && !at.containsKey(_students[i].id)) {
        /// Create a new map item with the staffId as the key a nested map as the content
        /// The nested map contains two items, the [details] key: which will have the student
        /// data as its content. And a [clocks] key which will contain the list of clocks or attendance
        /// Note: the clocks can be an empty List
        at[_students[i].id] = {'details': _students[i].data(), 'clocks': []};
        // ++numOfAbsentStudents;
      } else if (_students.length > i && at.containsKey(_students[i].id)) {
        at[_students[i].id]['details'] = _students[i].data();
      }

      if (att != null && !at.containsKey(_key)) {
        at[_key] = {
          'details': <String, dynamic>{},
          'clocks': [att]
        };
        // ++numOfPresentStudents;
        // if (att['type'] == 'in')
        //   ++numOfStudentsOnCampus;
        // else
        //   ++numOfStudentsOutCampus;
      } else if (att != null && at.containsKey(_key)) {
        at[_key]['clocks'].add(att);

        // if (att['type'] == 'in')
        //   ++numOfStudentsOnCampus;
        // else
        //   ++numOfStudentsOutCampus;
      }
    }
  }

  attendanceSummary(Map<String, dynamic> attendanceLog) {
    attendanceLog.forEach((key, value) {
      if (value['clocks'].length == 0) {
        ++numOfAbsentStudents;
      } else {
        ++numOfPresentStudents;
        if (value['clocks'].last['type'] == 'in') {
          ++numOfStudentsOnCampus;
        } else {
          ++numOfStudentsOutCampus;
        }
      }
    });
  }

  void _unsubscribe(_subscription) {
    _subscription!.cancel();
  }

  searchStudent(String searchKey) {
    _filteredStudents = _students.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Student student = Student.fromMapObject(docSnapshot.data());
      return student.fullName().toString().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortStudentList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredStudents.sort((a, b) {
        Student farmer1 = Student.fromMapObject(a.data());
        Student farmer2 = Student.fromMapObject(b.data());
        return farmer1
            .toMap()[columnName]
            .compareTo(farmer2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredStudents.sort((a, b) {
        Student farmer1 = Student.fromMapObject(a.data());
        Student farmer2 = Student.fromMapObject(b.data());
        return farmer2
            .toMap()[columnName]
            .compareTo(farmer1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }

  // searchStudent(String searchKey) {
  //   _filteredAttendance = _attendance.where((docSnapshot) {
  //     // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
  //     // return false;
  //     Student student = Student.fromMapObject(docSnapshot.data()!);
  //     return student.staffId.toString().contains(searchKey.toLowerCase());
  //   }).toList();
  //   notifyListeners();
  // }

  // sortStudentList(String columnName, int index, bool sorted) {
  //   sortColumnIndex = index;
  //   if (sortAscending) {
  //     sortAscending = false;
  //     _filteredAttendance.sort((a, b) {
  //       Student farmer1 = Student.fromMapObject(a.data()!);
  //       Student farmer2 = Student.fromMapObject(b.data()!);
  //       return farmer1
  //           .toMap()[columnName]
  //           .compareTo(farmer2.toMap()[columnName]);
  //     });
  //   } else {
  //     sortAscending = true;
  //     _filteredAttendance.sort((a, b) {
  //       Student farmer1 = Student.fromMapObject(a.data()!);
  //       Student farmer2 = Student.fromMapObject(b.data()!);
  //       return farmer2
  //           .toMap()[columnName]
  //           .compareTo(farmer1.toMap()[columnName]);
  //     });
  //   }
  //   notifyListeners();
  // }
}
