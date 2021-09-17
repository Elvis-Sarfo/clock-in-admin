// import 'dart:async';
// import 'package:clock_in_admin/models/teacher.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum TeacherControl { attendance, teachers }

// class TeacherAttendanceController extends ChangeNotifier {
//   final TeacherControl? teacherControl;
//   final BuildContext? context;
//   final String collectionName = 'teacher_clocks';
//   Map<String, dynamic> _attendance = {}, _filteredAttendance = {};
//   List<QueryDocumentSnapshot> _teachers = [], _filteredTeachers = [];
//   StreamSubscription? _subscription, _subscription1;

//   int sortColumnIndex = 1;
//   bool waiting = true,
//       hasError = false,
//       done = false,
//       sortAscending = true,
//       isUpdatingTeacher = false,
//       showErrorMsg = false;

//   int numOfPresentTeachers = 0;
//   int numOfAbsentTeachers = 0;
//   int numOfTeachersOnCampus = 0;
//   int numOfTeachersOutCampus = 0;
//   int totalNumOfTeachers = 0;

//   // contrusctor
//   TeacherAttendanceController({this.context, this.teacherControl}) {
//     streamTeachersAttendanceData();
//   }

// // Getters
//   Map<String, dynamic> get getTeachersAttendance => _attendance;
//   Map<String, dynamic> get getTeachersFitteredAttendance => _filteredAttendance;
//   List get getTeachers => _teachers;
//   List get getFilteredTeachers => _filteredTeachers;

//   @override
//   void dispose() {
//     _unsubscribe(_subscription);
//     super.dispose();
//   }

//   streamTeachersAttendanceData() async {
//     var now = DateTime.now();
//     var lastMidnight =
//         DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

//     // Get teacher in the database
//     // var _teachersSnap = await FirestoreDB.getAll('teachers');
//     // var _teachers = _teachersSnap.docs.toList();

//     // get the total number of teachers in the database
//     // totalNumOfTeachers = _teachers.length;

//     _subscription1 =
//         FirebaseFirestore.instance.collection('teachers').snapshots().listen(
//       (_teachersSnap)
//       //  {
//       //   var _teachers = _teachersSnap.docs.toList();
//       //   totalNumOfTeachers = _teachers.length;

//       //   startAttendanceStream(lastMidnight, _teachers);
//       //   notifyListeners();
//       // },
//       {
//         _filteredTeachers = _teachers = _teachersSnap.docs.toList();
//         totalNumOfTeachers = _teachers.length;

//         startAttendanceStream(lastMidnight, _teachers);

//         waiting = false;
//         notifyListeners();
//       },
//       onError: (Object error, StackTrace stackTrace) {
//         hasError = true;
//         notifyListeners();
//       },
//       onDone: () {
//         done = true;
//         notifyListeners();
//       },
//     );
//   }

//   void startAttendanceStream(
//       int lastMidnight, List<QueryDocumentSnapshot> _teachers) {
//     _subscription = FirebaseFirestore.instance
//         .collection(collectionName)
//         .where('time', isGreaterThanOrEqualTo: lastMidnight)
//         // .orderBy('teacherId')
//         .orderBy('time')
//         .snapshots()
//         .listen(
//       (data) async {
//         var _data = data.docs.toList();
//         Map<String, dynamic> at = Map();

//         numOfPresentTeachers = 0;
//         numOfAbsentTeachers = 0;
//         numOfTeachersOnCampus = 0;
//         numOfTeachersOutCampus = 0;

//         /// Generate attendance log
//         generateAttendanceLog(_teachers, _data, at);
//         attendanceSummary(at);

//         // print(at);
//         _attendance = at;
//         waiting = false;
//         notifyListeners();

//         // attendanceSummary(at);
//         // notifyListeners();
//       },
//       onError: (Object error, StackTrace stackTrace) {
//         hasError = true;
//         notifyListeners();
//       },
//       onDone: () {
//         done = true;
//         notifyListeners();
//       },
//     );
//   }

//   void generateAttendanceLog(List<dynamic> _teachers,
//       List<QueryDocumentSnapshot> _data, Map<String, dynamic> at) {
//     /// Get the maximum number of iterations to be done
//     /// Thisis done by comparing the lenght of the teachers list and the lenght
//     /// of the teacher attendance list then return the lenght of the greater one
//     var _maxIterations =
//         _teachers.length > _data.length ? _teachers.length : _data.length;

//     /// The loop starts here
//     for (var i = 0; i < _maxIterations; i++) {
//       // The att and the _key variable will hold the current attendance data in the list
//       // and the staffId respectively
//       var att, _key;

//       /// Check if the attendance list is greater than the loops counter before
//       /// assigning values to variable
//       /// This is done to make sure that we dont access undefined elements in the list
//       if (_data.length > i) {
//         att = _data[i].data();
//         _key = att!['teacherId'];
//       }

//       /// Check if the lennght of teachers list is greater than the loop counter
//       /// to prevent accessing undefined items from the teachers list.
//       /// Again, check if the final Map does not contain the key already
//       if (_teachers.length > i && !at.containsKey(_teachers[i].id)) {
//         /// Create a new map item with the staffId as the key a nested map as the content
//         /// The nested map contains two items, the [details] key: which will have the teacher
//         /// data as its content. And a [clocks] key which will contain the list of clocks or attendance
//         /// Note: the clocks can be an empty List
//         at[_teachers[i].id] = {'details': _teachers[i].data(), 'clocks': []};
//         // ++numOfAbsentTeachers;
//       } else if (_teachers.length > i && at.containsKey(_teachers[i].id)) {
//         at[_teachers[i].id]['details'] = _teachers[i].data();
//       }

//       if (att != null && !at.containsKey(_key)) {
//         at[_key] = {
//           'details': <String, dynamic>{},
//           'clocks': [att]
//         };
//         // ++numOfPresentTeachers;
//         // if (att['type'] == 'in')
//         //   ++numOfTeachersOnCampus;
//         // else
//         //   ++numOfTeachersOutCampus;
//       } else if (att != null && at.containsKey(_key)) {
//         at[_key]['clocks'].add(att);

//         // if (att['type'] == 'in')
//         //   ++numOfTeachersOnCampus;
//         // else
//         //   ++numOfTeachersOutCampus;
//       }
//     }
//   }

//   attendanceSummary(Map<String, dynamic> attendanceLog) {
//     attendanceLog.forEach((key, value) {
//       if (value['clocks'].length == 0) {
//         ++numOfAbsentTeachers;
//       } else {
//         ++numOfPresentTeachers;
//         if (value['clocks'].last['type'] == 'in') {
//           ++numOfTeachersOnCampus;
//         } else {
//           ++numOfTeachersOutCampus;
//         }
//       }
//     });
//   }

//   void _unsubscribe(_subscription) {
//     _subscription!.cancel();
//   }

//   searchTeacher(String searchKey) {
//     _filteredTeachers = _teachers.where((docSnapshot) {
//       // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
//       // return false;
//       Teacher teacher = Teacher.fromMapObject(docSnapshot.data());
//       return teacher.fullName().toString().contains(searchKey.toLowerCase());
//     }).toList();
//     notifyListeners();
//   }

//   sortTeacherList(String columnName, int index, bool sorted) {
//     sortColumnIndex = index;
//     if (sortAscending) {
//       sortAscending = false;
//       _filteredTeachers.sort((a, b) {
//         Teacher farmer1 = Teacher.fromMapObject(a.data());
//         Teacher farmer2 = Teacher.fromMapObject(b.data());
//         return farmer1
//             .toMap()[columnName]
//             .compareTo(farmer2.toMap()[columnName]);
//       });
//     } else {
//       sortAscending = true;
//       _filteredTeachers.sort((a, b) {
//         Teacher farmer1 = Teacher.fromMapObject(a.data());
//         Teacher farmer2 = Teacher.fromMapObject(b.data());
//         return farmer2
//             .toMap()[columnName]
//             .compareTo(farmer1.toMap()[columnName]);
//       });
//     }
//     notifyListeners();
//   }

//   // searchTeacher(String searchKey) {
//   //   _filteredAttendance = _attendance.where((docSnapshot) {
//   //     // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
//   //     // return false;
//   //     Teacher teacher = Teacher.fromMapObject(docSnapshot.data()!);
//   //     return teacher.staffId.toString().contains(searchKey.toLowerCase());
//   //   }).toList();
//   //   notifyListeners();
//   // }

//   // sortTeacherList(String columnName, int index, bool sorted) {
//   //   sortColumnIndex = index;
//   //   if (sortAscending) {
//   //     sortAscending = false;
//   //     _filteredAttendance.sort((a, b) {
//   //       Teacher farmer1 = Teacher.fromMapObject(a.data()!);
//   //       Teacher farmer2 = Teacher.fromMapObject(b.data()!);
//   //       return farmer1
//   //           .toMap()[columnName]
//   //           .compareTo(farmer2.toMap()[columnName]);
//   //     });
//   //   } else {
//   //     sortAscending = true;
//   //     _filteredAttendance.sort((a, b) {
//   //       Teacher farmer1 = Teacher.fromMapObject(a.data()!);
//   //       Teacher farmer2 = Teacher.fromMapObject(b.data()!);
//   //       return farmer2
//   //           .toMap()[columnName]
//   //           .compareTo(farmer1.toMap()[columnName]);
//   //     });
//   //   }
//   //   notifyListeners();
//   // }
// }
