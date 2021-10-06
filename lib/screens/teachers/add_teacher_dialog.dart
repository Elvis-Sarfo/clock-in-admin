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
import 'package:flutter/material.dart';

class AddTeacherDialog extends StatefulWidget {
  AddTeacherDialog({Key? key}) : super(key: key);

  @override
  _AddTeacherDialogState createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  // Get a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Instanciate a new Teacher
  final Teacher _teacher = new Teacher();

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
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  // Group the like form fields
  final _fieldGroupBuilder = (Teacher model) => [
        CustomTextFormField(
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
                        onImageSelected: (image) async {
                          profileImage = image;
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: _fieldGroupBuilder(_teacher),
                      ))
                    ],
                  ),
                if (!Responsive.isDesktop(context))
                  ImageChooser(onImageSelected: (image) async {
                    profileImage = image;
                  }),
                if (!Responsive.isDesktop(context)) SizedBox(height: 10),
                if (!Responsive.isDesktop(context))
                  ..._fieldGroupBuilder(_teacher),
                // ###################################################
                // Gender field
                GenderSelector(
                  onChanged: (value) => _teacher.gender = value,
                  onSaved: (value) => _teacher.gender = value,
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
                  onSaved: (value) => _teacher.residence = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Phone field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.phone, color: Colors.black45),
                  hintText: 'Phone',
                  onSaved: (value) => _teacher.phone = value,
                  validator: validatePhoneNumber,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Email field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.email, color: Colors.black45),
                  hintText: 'Email',
                  onSaved: (value) => _teacher.email = value,
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
                  onSaved: (value) => _teacher.department = value,
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
                  onSaved: (value) => _teacher.subject = value,
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
                  onSaved: (value) => _teacher.position = value,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Position in School field
                // DropDownField(
                //   prefixIcon: Icon(Icons.person, color: Colors.black54),
                //   onSaved: (value) => _teacher.position = value,
                // ),
                // SizedBox(
                //   height: 10,
                // ),

                SizedBox(
                  height: 10,
                ),
                MainButton(
                  isLoading: _isLoading,
                  color: Styles.primaryColor,
                  title: 'Save Teacher',
                  tapEvent: saveTeacherinDB,
                ),
                // ElevatedButton.icon(
                //   style: TextButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: Styles.defaultPadding * 1.5,
                //       vertical: Styles.defaultPadding /
                //           (Responsive.isMobile(context) ? 2 : 1),
                //     ),
                //   ),
                //   onPressed: saveTeacherinDB,
                //   icon: Icon(Icons.save),
                //   label: Text("Save Data"),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Saves the data in the database
  saveTeacherinDB() async {
    // TOdo: Might add this task to the contoller of provider
    // todo: Add a layer to cover the dialog and show progress of the task
    // _formKey.currentState!.save();
    // print(_teacher.toMap());
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        showErrorMsg = false;
      });

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // Sign teacher in with email and password
        // Defualt password is the STAFFID of the teacher
        var authResult = await Auth.signUpWithEmailandPassword(
          email: _teacher.email,
          password: _teacher.staffId,
        );

        print(authResult);
        // todo: Check if the user is signed up first before you continue the next task
        var result = await FirestoreDB.addDocWithId(
          'teachers',
          _teacher.toMap(),
          _teacher.staffId,
        );
        // todo: after saving the image, update the user feild
        if (result == 'saved') {
          // save the image in the firebase storage
          var imageUrl = (profileImage != null)
              ? await FirestoreDB.saveFile(profileImage, '/teachers/',
                  _teacher.fullName()!.replaceAll(' ', '_'))
              : null;
          Map<String, dynamic> uppdate = {"picture": imageUrl};
          // update the teacher pictureURL field
          await FirestoreDB.updateDoc(
            'teachers',
            _teacher.staffId,
            uppdate,
          );

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
  }
}
