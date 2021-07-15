import 'package:clock_in_admin/components/auto_complete_input.dart';
import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/drop_down_field.dart';
import 'package:clock_in_admin/components/gender_selector.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/services/auth_services.dart';
import 'package:clock_in_admin/services/database_services.dart';
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
  bool isLoading = false;

  // Group the like form fields
  final _fieldGroupBuilder = (Teacher model) => [
        CustomTextFormField(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black54,
          ),
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
          prefixIcon: Icon(Icons.person),
          hintText: 'Firstname',
          onSaved: (value) => model.firstName = value,
          validator: emptyFeildValidator,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          prefixIcon: Icon(Icons.person),
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
              : size.width * 0.5,
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
                AutocompleteBasicExample(),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Phone field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
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
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Email',
                  onSaved: (value) => _teacher.email = value,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Subject Taught field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Subject',
                  onSaved: (value) => _teacher.subject = value,
                  validator: emptyFeildValidator,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Town of residence field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Town of Residence',
                  onSaved: (value) => _teacher.residence = value,
                  validator: emptyFeildValidator,
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Position in School field
                DropDownField(
                  prefixIcon: Icon(Icons.person, color: Colors.black54),
                  onSaved: (value) => _teacher.position = value,
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Styles.defaultPadding * 1.5,
                      vertical: Styles.defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: saveTeacherinDB,
                  icon: Icon(Icons.upload),
                  label: Text("Save Data"),
                ),
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
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        var authResult = await Auth.signUpWithEmailandPassword(
          email: _teacher.email,
          password: _teacher.staffId,
        );
        print(authResult);
        // todo: Check if the user is signed up first before you continue the next task
        var result = await FirestoreDB.addDocWithId(
            'teachers', _teacher.toMap(), _teacher.staffId);
        // todo: after saving the image, update the user feild
        if (result != 'saved') {
          var imageUrl = (profileImage != null)
              ? await FirestoreDB.saveFile(profileImage, '/farmers/',
                  _teacher.fullName()!.replaceAll(' ', '_'))
              : null;
          setState(() {
            isLoading = false;
            if (result != 'saved') {
              errMsg = result;
              showErrorMsg = true;
            }
          });
        } else {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          isLoading = false;
          showErrorMsg = false;
        });
      }
    }
  }

  _onImageSeleceted() {}
}
