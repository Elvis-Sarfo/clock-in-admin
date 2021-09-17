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
import 'package:flutter/material.dart';

class AddStudentDialog extends StatefulWidget {
  AddStudentDialog({Key? key}) : super(key: key);

  @override
  _AddStudentDialogState createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  // Get a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Instanciate a new Student
  final Student _student = new Student();

  // Instanciate a new Guardian
  final Guardian _guardian = new Guardian();

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

  final TextEditingController locationController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController guardianlocationController =
      TextEditingController();

  // Group the like form fields
  final _fieldGroupBuilder = (Student model) => [
        CustomTextFormField(
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
          prefixIcon: Icon(Icons.person, color: Colors.black45),
          hintText: 'Firstname',
          onSaved: (value) => model.firstName = value,
          validator: emptyFeildValidator,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
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
                        children: _fieldGroupBuilder(_student),
                      ))
                    ],
                  ),
                if (!Responsive.isDesktop(context))
                  ImageChooser(onImageSelected: (image) async {
                    profileImage = image;
                  }),
                if (!Responsive.isDesktop(context)) SizedBox(height: 10),
                if (!Responsive.isDesktop(context))
                  ..._fieldGroupBuilder(_student),
                // ###################################################
                // Gender field
                GenderSelector(
                  onChanged: (value) => _student.gender = value,
                  onSaved: (value) => _student.gender = value,
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
                  onSaved: (value) => _student.residence = value,
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
                  onSaved: (value) => _student.course = value,
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
                  onSaved: (value) => _student.position = value,
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
                        controller: relationshipController,
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
                  title: 'Save Student',
                  tapEvent: saveStudentinDB,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Saves the data in the database
  saveStudentinDB() async {
    // TOdo: Might add this task to the contoller of provider
    try {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
          showErrorMsg = false;
        });

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          _student.guardian = _guardian.toMap();

          var result = await FirestoreDB.addDocWithId(
            'students',
            _student.toMap(),
            _student.id,
          );
          // After saving the image, update the user feild
          if (result == 'saved') {
            // save the image in the firebase storage
            await uploadProfilePicture();

            setState(() {
              _isLoading = false;
              if (result != 'saved') {
                errMsg = result;
                showErrorMsg = true;
              }
            });
            _isLoading = false;
            Navigator.of(context).pop();
          } else {
            setState(() {
              _isLoading = false;
              errMsg = result;
              showErrorMsg = true;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
            showErrorMsg = false;
          });
        }
      }
    } on Exception catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
        showErrorMsg = false;
      });
    }
  }

  Future<void> uploadProfilePicture() async {
    // save the image in the firebase storage
    if (profileImage != null) {
      var imageUrl = await FirestoreDB.saveFile(profileImage, '/students/',
          _student.fullName()!.replaceAll(' ', '_'));
      Map<String, dynamic> uppdate = {"picture": imageUrl};
      // update the student pictureURL field
      await FirestoreDB.updateDoc(
        'students',
        _student.id,
        uppdate,
      );
    }
  }
}
