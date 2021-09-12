import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clock_in_admin/models/teacher.dart';

class TeacherController extends ChangeNotifier {
  final String collectionName = 'teachers';
  List<DocumentSnapshot> _teachers = [], _filteredTeachers = [];
  StreamSubscription? _subscription;
  int sortColumnIndex = 1;
  bool waiting = true, hasError = false, done = false, sortAscending = true;

  TeacherController() {
    streamTeachersData();
  }

  List get getTeachers => _teachers;
  List get getFilteredTeachers => _filteredTeachers;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  streamTeachersData() async {
    _subscription = FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .listen(
      (data) {
        _filteredTeachers = _teachers = data.docs.toList();
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

  searchTeacher(String searchKey) {
    _filteredTeachers = _teachers.where((docSnapshot) {
      // print(docSnapshot.data()['dateOfBirth'] is Timestamp);
      // return false;
      Teacher teacher = Teacher.fromMapObject(docSnapshot.data()!);
      return teacher.staffId.toString().contains(searchKey.toLowerCase());
    }).toList();
    notifyListeners();
  }

  sortTeacherList(String columnName, int index, bool sorted) {
    sortColumnIndex = index;
    if (sortAscending) {
      sortAscending = false;
      _filteredTeachers.sort((a, b) {
        Teacher farmer1 = Teacher.fromMapObject(a.data()!);
        Teacher farmer2 = Teacher.fromMapObject(b.data()!);
        return farmer1
            .toMap()[columnName]
            .compareTo(farmer2.toMap()[columnName]);
      });
    } else {
      sortAscending = true;
      _filteredTeachers.sort((a, b) {
        Teacher farmer1 = Teacher.fromMapObject(a.data()!);
        Teacher farmer2 = Teacher.fromMapObject(b.data()!);
        return farmer2
            .toMap()[columnName]
            .compareTo(farmer1.toMap()[columnName]);
      });
    }
    notifyListeners();
  }
}












// import 'package:clock_in_admin/models/teacher.dart';
// import 'package:clock_in_admin/services/database_services.dart';
// import 'package:flutter/material.dart';

// class TeacherController extends ChangeNotifier {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

//   /// The Error msg that will be shown to the user if there are any error whilst
//   /// Performing any operation on the data
//   String errMsg = '';

//   /// Profile Image, holds the image that will be selected by the user
//   var profileImage;

//   /// Error Message tracker
//   ///
//   /// It is set to [false] when the the error msg is not shown
//   /// and [true] when the error msg is shown or displayed
//   bool showErrorMsg = false;

//   /// Tracks the operations in this widget
//   ///
//   /// It is set to [false] when there is no operation in progress
//   /// and [true] when there is an operation in progress
//   bool isLoading = false;

//   /// Saves the data in the database
//   saveTeacherinDB(Teacher teacher, ) async {
//     // _formKey.currentState!.save();
//     // print(_teacher.toMap());
//     if (!isLoading) {
//       setState(() {
//         isLoading = true;
//         showErrorMsg = false;
//       });

//       if (_formKey.currentState!.validate()) {
//         _formKey.currentState!.save();

//         var result = await FirestoreDB.addDocWithId(
//             'teachers', teacher.toMap(), teacher.staffId);

//         if (result != 'saved') {
//           var imageUrl = (profileImage != null)
//               ? await FirestoreDB.saveFile(profileImage, '/teachers/',
//                   teacher.fullName()!.replaceAll(' ', '_'))
//               : null;
//           setState(() {
//             isLoading = false;
//             if (result != 'saved') {
//               errMsg = result;
//               showErrorMsg = true;
//             }
//           });
//         } else {
//           Navigator.of(context).pop();
//         }
//       } else {
//         setState(() {
//           isLoading = false;
//           showErrorMsg = false;
//         });
//       }
//     }
//   }
// }
