import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/gender_selector.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/components/main_button.dart';
import 'package:clock_in_admin/components/type_ahead_input.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/services/auth_services.dart';
import 'package:clock_in_admin/services/cities_services.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:clock_in_admin/services/department_services.dart';
import 'package:clock_in_admin/services/positions_services.dart';
import 'package:clock_in_admin/services/subject_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/form_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTeacherDialog extends StatefulWidget {
  final Teacher? teacher;
  UpdateTeacherDialog({Key? key, this.teacher}) : super(key: key);

  @override
  _UpdateTeacherDialogState createState() => _UpdateTeacherDialogState();
}

class _UpdateTeacherDialogState extends State<UpdateTeacherDialog> {
  // Get a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Instanciate a new Teacher
  late Teacher? _teacher;

  /// The Error msg that will be shown to the user if there are any error whilst
  /// Performing any operation on the data
  String errMsg = '';

  /// Profile Image, holds the image that will be selected by the user
  var profileImage;

  /// Error Message tracker
  ///
  /// It is set to [false] when the the error msg is not shown
  /// and [true] when the error msg is shown or displayed
  bool showErrorMsg = false;

  /// Tracks the operations in this widget
  ///
  /// It is set to [false] when there is no operation in progress
  /// and [true] when there is an operation in progress
  bool _isLoading = false;

// Controllers for the form feilds
  late TextEditingController locationController;
  late TextEditingController subjectController;
  late TextEditingController positionController;
  late TextEditingController departmentController;
  late TextEditingController staffIdController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController genderController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    // create a new object for the teacher
    _teacher = Teacher.fromMapObject(widget.teacher!.toMap());
    staffIdController = TextEditingController(text: _teacher?.staffId ?? '');
    locationController = TextEditingController(text: _teacher?.residence ?? '');
    subjectController = TextEditingController(text: _teacher?.subject ?? '');
    positionController = TextEditingController(text: _teacher?.position ?? '');
    departmentController =
        TextEditingController(text: _teacher?.department ?? '');
    firstnameController =
        TextEditingController(text: _teacher?.firstName ?? '');
    lastnameController = TextEditingController(text: _teacher?.lastName ?? '');
    phoneController = TextEditingController(text: _teacher?.phone ?? '');
    emailController = TextEditingController(text: _teacher?.email ?? '');

    super.initState();
  }

  // Group the like form fields
  final _fieldGroupBuilder = (Teacher model, a, b, c) => [
        CustomTextFormField(
          controller: a,
          prefixIcon: Icon(Icons.account_circle, color: Colors.black45),
          hintText: 'Staff Id',
          onSaved: (value) {
            model.staffId = value;
          },
          validator: emptyFeildValidator,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: b,
          prefixIcon: Icon(Icons.person, color: Colors.black45),
          hintText: 'Firstname',
          onSaved: (value) => model.firstName = value,
          validator: emptyFeildValidator,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: c,
          prefixIcon: Icon(Icons.person, color: Colors.black45),
          hintText: 'Lastname',
          onSaved: (value) => model.lastName = value,
          validator: emptyFeildValidator,
        ),
        SizedBox(
          height: 10,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: Styles.defaultPadding,
        vertical: 5,
      ),
      backgroundColor: Styles.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add New Teacher'),
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
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: Styles.defaultPadding, vertical: 0),
          width: (Responsive.isMobile(context))
              ? size.width * 0.9
              : size.width * 0.4,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (Responsive.isDesktop(context))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageChooser(
                        defaultNetworkImage: _teacher!.picture,
                        onImageSelected: (image) async {
                          profileImage = image;
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: _fieldGroupBuilder(
                          _teacher!,
                          staffIdController,
                          firstnameController,
                          lastnameController,
                        ),
                      ))
                    ],
                  ),
                if (!Responsive.isDesktop(context))
                  ImageChooser(onImageSelected: (image) async {
                    profileImage = image;
                  }),
                if (!Responsive.isDesktop(context)) SizedBox(height: 10),
                if (!Responsive.isDesktop(context))
                  ..._fieldGroupBuilder(
                    _teacher!,
                    staffIdController,
                    firstnameController,
                    lastnameController,
                  ),
                // ###################################################
                // Gender field
                GenderSelector(
                  groupValue: _teacher!.gender,
                  onChanged: (value) => _teacher!.gender = value,
                  onSaved: (value) => _teacher!.gender = value,
                ),
                SizedBox(
                  height: 10.0,
                ),
                // ###################################################
                TypeAheadInput(
                  hintText: 'Town of Residence',
                  prefixIcon: Icon(Icons.place, color: Colors.black45),
                  controller: locationController,
                  suggestionsCallback: (pattern) {
                    return CitiesService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _teacher!.residence = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Phone field
                CustomTextFormField(
                  controller: phoneController,
                  prefixIcon: Icon(Icons.phone, color: Colors.black45),
                  hintText: 'Phone',
                  onSaved: (value) => _teacher!.phone = value,
                  validator: validatePhoneNumber,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Email field
                CustomTextFormField(
                  controller: emailController,
                  prefixIcon: Icon(Icons.email, color: Colors.black45),
                  hintText: 'Email',
                  onSaved: (value) => _teacher!.email = value,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Subject Taught field
                TypeAheadInput(
                  hintText: 'Department',
                  prefixIcon: Icon(Icons.book, color: Colors.black45),
                  controller: departmentController,
                  suggestionsCallback: (pattern) {
                    return DepartmentsService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _teacher!.department = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Subject Taught field
                TypeAheadInput(
                  hintText: 'Subject',
                  prefixIcon: Icon(Icons.book, color: Colors.black45),
                  controller: subjectController,
                  suggestionsCallback: (pattern) {
                    return SubjectsService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _teacher!.subject = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Teacher position in the school
                TypeAheadInput(
                  hintText: 'Postion in School',
                  prefixIcon: Icon(Icons.group, color: Colors.black45),
                  controller: positionController,
                  suggestionsCallback: (pattern) {
                    return PositionsService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _teacher!.position = value,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                MainButton(
                  isLoading: _isLoading,
                  color: Styles.primaryColor,
                  title: 'Save Teacher',
                  tapEvent: updateTeacherinDB,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Saves the data in the database
  updateTeacherinDB() async {
    // TOdo: Might add this task to the contoller of provider
    // todo: Add a layer to cover the dialog and show progress of the task
    try {
      if (!_isLoading) {
        // set the loading to [true] to show the loading button
        setState(() {
          _isLoading = true;
          showErrorMsg = false;
        });

        // Check if the form state is valid
        if (_formKey.currentState!.validate()) {
          // invoce form save method
          _formKey.currentState!.save();

          // Sign teacher in with email and password
          // Defualt password is the STAFFID of the teacher
          if (widget.teacher!.email != _teacher!.email) {
            var authResult = await Auth.signUpWithEmailandPassword(
              email: _teacher!.email,
              password: _teacher!.staffId,
            );
          }

          // todo: Check if the user is signed up first before you continue the next task
          // variable to hold te results of the database actions
          var result;

          /// Check if the staff changed
          /// if it has not changed update the rest of the fields
          /// else delete create a new document with a new ID and delete the old
          /// from the databse collection.
          /// Again if the staffID has changed, cascade through the teacher log of
          ///  the old staffID andupdate the IDs to have the new staff ID
          if (widget.teacher!.staffId == _teacher!.staffId) {
            // update the document
            result = await FirestoreDB.updateDoc(
              'teachers',
              _teacher!.staffId,
              _teacher!.toMap(),
            );
          } else {
            // Save the new teacher data with the new StaffID
            result = await updateStaffId(result);
          }

          // print the results of the firebase
          print(result);

          // save the image in the firebase storage
          await uploadProfilePicture();

          // TeacherAttendanceController().streamTeachersAttendanceData();
          Navigator.of(context).pop();
        } else {
          setState(() {
            _isLoading = false;
            showErrorMsg = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        showErrorMsg = false;
      });
    }
  }

  Future<void> uploadProfilePicture() async {
    if (profileImage != null) {
      var imageUrl = await FirestoreDB.saveFile(profileImage, '/teachers/',
          _teacher!.fullName()!.replaceAll(' ', '_'));

      Map<String, dynamic> uppdate = {"picture": imageUrl};
      await FirestoreDB.updateDoc('teachers', _teacher!.staffId, uppdate);
    }
  }

  Future<dynamic> updateStaffId(result) async {
    result = await FirestoreDB.addDocWithId(
      'teachers',
      _teacher!.toMap(),
      _teacher!.staffId,
    );
    // Delete the old the data of the teacher
    await FirestoreDB.deleteDoc('teachers', widget.teacher!.staffId);

    // Cascade through the attendance log of the teacher and update all
    // the staff ids in the  database

    // create the update object
    Map<String, dynamic> update = {"teacherId": _teacher!.staffId};

    // creates the collection reference of the teacher log
    final CollectionReference teacherClocks =
        FirebaseFirestore.instance.collection('teacher_clocks');

    // Get the teacher  attendance log datafrom the databse using the old staffID
    var snapshot = await teacherClocks
        .where('teacherId', isEqualTo: widget.teacher!.staffId)
        .orderBy('time', descending: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      /// Use a batch to update all the documents that returns
      WriteBatch writeBatch = FirebaseFirestore.instance.batch();
      snapshot.docs.forEach((doc) async {
        var docRef = teacherClocks.doc(doc.id);
        writeBatch.update(docRef, update);
      });

      // Comit the batch operation in the database.
      await writeBatch.commit();
      print('updated all documents inside');
    }

    return result;
  }

  _onImageSeleceted() {}
}
