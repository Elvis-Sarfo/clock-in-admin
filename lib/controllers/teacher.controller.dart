import 'dart:async';
import 'package:clock_in_admin/services/auth_services.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clock_in_admin/models/teacher.dart';

class TeacherController extends ChangeNotifier {
  final String collectionName = 'teachers';
  List<DocumentSnapshot> _teachers = [], _filteredTeachers = [];
  StreamSubscription? _subscription;
  int sortColumnIndex = 1;
  bool waiting = true,
      hasError = false,
      done = false,
      sortAscending = true,
      isUpdatingTeacher = false,
      showErrorMsg = false;

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

  /// Saves the data in the database
  // updateTeacherinDB(Teacher oldTeacher, Teacher newTeacher, GlobalKey<FormState> _formKey, profileImage) async {
  //   // TOdo: Might add this task to the contoller of provider
  //   // todo: Add a layer to cover the dialog and show progress of the task
  //   try {
  //     if (!isUpdatingTeacher) {
  //         isUpdatingTeacher = true;
  //         showErrorMsg = false;
  //         notifyListeners();

  //       if (_formKey.currentState!.validate()) {
  //         _formKey.currentState!.save();

  //         // Sign teacher in with email and password
  //         // Defualt password is the STAFFID of the teacher
  //         if (oldTeacher.email != newTeacher.email) {
  //           var authResult = await Auth.signUpWithEmailandPassword(
  //             email: newTeacher.email,
  //             password: newTeacher.staffId,
  //           );
  //         }
  //         var result;
  //         // todo: Check if the user is signed up first before you continue the next task
  //         if (oldTeacher.staffId == newTeacher.staffId) {
  //           result = await FirestoreDB.updateDoc(
  //             'teachers',
  //             newTeacher.staffId,
  //             newTeacher.toMap(),
  //           );
  //         } else {
  //           // Save the new teacher data with the new StaffID
  //           result = await FirestoreDB.addDocWithId(
  //             'teachers',
  //             newTeacher.toMap(),
  //             newTeacher.staffId,
  //           );
  //           // Delete the old the data of the teacher
  //           await FirestoreDB.deleteDoc('teachers', newTeacher.staffId);

  //           // todo: Cascade through the attendance log and update all the staff ids in the  database
  //           Map<String, dynamic> update = {"teacherId": newTeacher.staffId};
  //           final CollectionReference teacherClocks =
  //               FirebaseFirestore.instance.collection('teacher_clocks');
  //           teacherClocks
  //               .where('teacherId', isEqualTo: newTeacher.staffId)
  //               .orderBy('time', descending: true)
  //               .get()
  //               .then((snapshot) async {
  //             WriteBatch writeBatch = FirebaseFirestore.instance.batch();
  //             snapshot.docs.forEach((doc) {
  //               var docRef = teacherClocks.doc(doc.id);
  //               writeBatch.update(docRef, update);
  //             });
  //             await writeBatch.commit();
  //             print('updated all documents inside');
  //           });
  //         }

  //         // print the results of the firebase
  //         print(result);

  //         // save the image in the firebase storage
  //         var imageUrl = (profileImage != null)
  //             ? await FirestoreDB.saveFile(profileImage, '/teachers/',
  //                 newTeacher.fullName()!.replaceAll(' ', '_'))
  //             : null;

  //         if (imageUrl != null) {
  //           // update the teacher pictureURL field
  //           Map<String, dynamic> uppdate = {"picture": imageUrl};
  //           await FirestoreDB.updateDoc('teachers', newTeacher.staffId, uppdate);
  //         }
  //         Navigator.of(context).pop();
  //       } else {
  //           isUpdatingTeacher = false;
  //           showErrorMsg = false;
  //         notifyListeners();
  //       }
  //     }
  //   } catch (e) {
  //       isUpdatingTeacher = false;
  //       showErrorMsg = false;
  //       notifyListeners();
  //   }
  // }

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
