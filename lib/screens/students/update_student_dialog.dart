import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/gender_selector.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/components/main_button.dart';
import 'package:clock_in_admin/components/type_ahead_input.dart';
import 'package:clock_in_admin/models/guardian.dart';
import 'package:clock_in_admin/models/student.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/services/cities_services.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:clock_in_admin/services/department_services.dart';
import 'package:clock_in_admin/services/positions_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/form_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentDialog extends StatefulWidget {
  final Student? student;
  UpdateStudentDialog({Key? key, this.student}) : super(key: key);

  @override
  _UpdateStudentDialogState createState() => _UpdateStudentDialogState();
}

class _UpdateStudentDialogState extends State<UpdateStudentDialog> {
  // Get a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Instanciate a new Student
  late Student? _student;

  // Instanciate a new Guardian
  late Guardian _guardian;

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
  late TextEditingController studentIdController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController locationController;
  late TextEditingController courseController;
  late TextEditingController positionController;

  late TextEditingController guardianFirstnameController;
  late TextEditingController guardianLastnameController;
  late TextEditingController guardianRelationshipController;
  late TextEditingController guardianPhoneController;
  late TextEditingController guardianEmailController;
  late TextEditingController guardianlocationController;

  @override
  void initState() {
    // create a new object for the student
    _student = Student.fromMapObject(widget.student!.toMap());
    _guardian = Guardian.fromMapObject(_student!.guardian);

    studentIdController = TextEditingController(text: _student?.id ?? '');
    firstnameController =
        TextEditingController(text: _student?.firstName ?? '');
    lastnameController = TextEditingController(text: _student?.lastName ?? '');
    locationController = TextEditingController(text: _student?.residence ?? '');
    courseController = TextEditingController(text: _student?.course ?? '');
    positionController = TextEditingController(text: _student?.position ?? '');

    guardianFirstnameController =
        TextEditingController(text: _guardian.firstName ?? '');
    guardianLastnameController =
        TextEditingController(text: _guardian.lastName ?? '');
    guardianRelationshipController =
        TextEditingController(text: _guardian.relationship ?? '');
    guardianPhoneController =
        TextEditingController(text: _guardian.phone ?? '');
    guardianEmailController =
        TextEditingController(text: _guardian.email ?? '');
    guardianlocationController =
        TextEditingController(text: _guardian.residence ?? '');

    super.initState();
  }

  // Group the like form fields
  final _fieldGroupBuilder = (Student model, a, b, c) => [
        CustomTextFormField(
          controller: a,
          prefixIcon: Icon(Icons.account_circle, color: Colors.black45),
          hintText: 'Student Id',
          onSaved: (value) {
            model.id = value;
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
      titlePadding:
          EdgeInsets.symmetric(horizontal: Styles.defaultPadding, vertical: 5),
      backgroundColor: Styles.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add New Student'),
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
                          _student!,
                          studentIdController,
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
                    _student!,
                    studentIdController,
                    firstnameController,
                    lastnameController,
                  ),
                // ###################################################
                // Gender field
                GenderSelector(
                  groupValue: _student!.gender,
                  onChanged: (value) => _student!.gender = value,
                  onSaved: (value) => _student!.gender = value,
                ),
                SizedBox(
                  height: 10.0,
                ),
                // ###################################################
                TypeAheadInput(
                  validator: emptyFeildValidator,
                  hintText: 'Town of Residence',
                  prefixIcon: Icon(Icons.place, color: Colors.black45),
                  controller: locationController,
                  suggestionsCallback: (pattern) {
                    return CitiesService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _student!.residence = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Subject Taught field
                TypeAheadInput(
                  validator: emptyFeildValidator,
                  hintText: 'Course of Study',
                  prefixIcon: Icon(Icons.book, color: Colors.black45),
                  controller: courseController,
                  suggestionsCallback: (pattern) {
                    return DepartmentsService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _student!.course = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Student position in the school
                TypeAheadInput(
                  hintText: 'Postion in School',
                  prefixIcon: Icon(Icons.group, color: Colors.black45),
                  controller: positionController,
                  suggestionsCallback: (pattern) {
                    return PositionsService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _student!.position = value,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  thickness: 1,
                  color: Styles.primaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Guardian Detials (Optional)',
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: guardianFirstnameController,
                        prefixIcon: Icon(Icons.person, color: Colors.black45),
                        hintText: 'FirstName',
                        onSaved: (value) => _guardian.firstName = value,
                        // validator: emptyFeildValidator,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        controller: guardianLastnameController,
                        prefixIcon: Icon(Icons.person, color: Colors.black45),
                        hintText: 'Lastname',
                        onSaved: (value) => _guardian.lastName = value,
                        // validator: emptyFeildValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GenderSelector(
                        groupValue: _guardian.gender,
                        onChanged: (value) => _guardian.gender = value,
                        onSaved: (value) => _guardian.gender = value,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TypeAheadInput(
                        prefixIcon: Icon(Icons.supervisor_account,
                            color: Colors.black45),
                        hintText: 'Realationship',
                        controller: guardianRelationshipController,
                        suggestionsCallback: (pattern) {
                          return CitiesService.getSuggestions(pattern);
                        },
                        onSaved: (value) => _guardian.relationship = value,
                        // validator: emptyFeildValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: guardianPhoneController,
                        prefixIcon: Icon(Icons.phone, color: Colors.black45),
                        hintText: 'Phone',
                        onSaved: (value) => _guardian.phone = value,
                        // validator: validatePhoneNumber,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        controller: guardianEmailController,
                        prefixIcon: Icon(Icons.email, color: Colors.black45),
                        hintText: 'Email',
                        onSaved: (value) => _guardian.email = value,
                        // validator: validateOptionalEmail,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                TypeAheadInput(
                  hintText: 'Town of Residence',
                  prefixIcon: Icon(Icons.place, color: Colors.black45),
                  controller: guardianlocationController,
                  suggestionsCallback: (pattern) {
                    return CitiesService.getSuggestions(pattern);
                  },
                  onSaved: (value) => _guardian.residence = value,
                ),

                SizedBox(
                  height: 10,
                ),
                MainButton(
                  isLoading: _isLoading,
                  color: Styles.primaryColor,
                  title: 'Update Student Data',
                  tapEvent: updateStudentinDB,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Saves the data in the database
  updateStudentinDB() async {
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
          _student!.guardian = _guardian.toMap();

          // variable to hold te results of the database actions
          var result;

          /// Check if the staff changed
          /// if it has not changed update the rest of the fields
          /// else delete create a new document with a new ID and delete the old
          /// from the databse collection.
          /// Again if the staffID has changed, cascade through the student log of
          ///  the old staffID andupdate the IDs to have the new staff ID
          if (widget.student!.id == _student!.id) {
            // update the document
            result = await FirestoreDB.updateDoc(
              'students',
              _student!.id,
              _student!.toMap(),
            );
          } else {
            // Save the new student data with the new StaffID
            result = await updateStudentId(result);
          }

          // print the results of the firebase
          // print(result);

          // save the image in the firebase storage
          await uploadProfilePicture();

          // StudentAttendanceController().streamStudentsAttendanceData();
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
    var imageUrl = (profileImage != null)
        ? await FirestoreDB.saveFile(profileImage, '/students/',
            _student!.fullName()!.replaceAll(' ', '_'))
        : null;

    if (imageUrl != null) {
      // update the student pictureURL field
      Map<String, dynamic> uppdate = {"picture": imageUrl};
      await FirestoreDB.updateDoc('students', _student!.id, uppdate);
    }
  }

  Future<dynamic> updateStudentId(result) async {
    result = await FirestoreDB.addDocWithId(
      'students',
      _student!.toMap(),
      _student!.id,
    );
    // Delete the old the data of the student
    await FirestoreDB.deleteDoc('students', widget.student!.id);

    // Cascade through the attendance log of the student and update all
    // the staff ids in the  database

    // create the update object
    Map<String, dynamic> update = {"studentId": _student!.id};

    // creates the collection reference of the student log
    final CollectionReference studentClocks =
        FirebaseFirestore.instance.collection('student_clocks');

    // Get the student  attendance log datafrom the databse using the old staffID
    var snapshot = await studentClocks
        .where('studentId', isEqualTo: widget.student!.id)
        .orderBy('time', descending: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      /// Use a batch to update all the documents that returns
      WriteBatch writeBatch = FirebaseFirestore.instance.batch();
      snapshot.docs.forEach((doc) async {
        var docRef = studentClocks.doc(doc.id);
        writeBatch.update(docRef, update);
      });

      // Comit the batch operation in the database.
      await writeBatch.commit();
      print('updated all documents inside');
    }

    return result;
  }
}
