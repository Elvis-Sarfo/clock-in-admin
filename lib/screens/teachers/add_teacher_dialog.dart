import 'package:clock_in_admin/components/auto_complete_input.dart';
import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/drop_down_field.dart';
import 'package:clock_in_admin/components/gender_selector.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/form_validator.dart';
import 'package:flutter/material.dart';

class AddTeacherDialog extends StatelessWidget {
  AddTeacherDialog({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Teacher _teacher = new Teacher();

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
                          // profileImage = image;
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
                  ImageChooser(onImageSelected: (image) async {}),
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
                AutocompleteBasicExample(),
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

  saveTeacherinDB() async {
    _formKey.currentState!.save();
    print(_teacher.toMap());
  }

  _onImageSeleceted() {}
}
