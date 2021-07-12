import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/date_picker.dart';
import 'package:clock_in_admin/components/drop_down_field.dart';
import 'package:clock_in_admin/components/gender_selector.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class AddTeacherDialog extends StatelessWidget {
  AddTeacherDialog({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _fieldGroup = [
    CustomTextFormField(
      prefixIcon: Icon(Icons.person),
      hintText: 'Staff Id',
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Feild must not be empty';
        }
        return null;
      },
    ),
    SizedBox(
      height: 10,
    ),
    CustomTextFormField(
      prefixIcon: Icon(Icons.person),
      hintText: 'Firstname',
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field must not be empty';
        }
        return null;
      },
    ),
    SizedBox(
      height: 10,
    ),
    CustomTextFormField(
      prefixIcon: Icon(Icons.person),
      hintText: 'Lastname',
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field must not be empty';
        }
        return null;
      },
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
                        children: _fieldGroup,
                      ))
                    ],
                  ),
                if (!Responsive.isDesktop(context))
                  ImageChooser(onImageSelected: (image) async {}),
                if (!Responsive.isDesktop(context)) SizedBox(height: 10),
                if (!Responsive.isDesktop(context)) ..._fieldGroup,
                // ###################################################
                // Gender field
                GenderSelector(
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Phone field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Phone',
                  onSaved: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Email field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Email',
                  onSaved: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Subject Taught field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Subject',
                  onSaved: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Town of residence field
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Town of Residence',
                  onSaved: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // ###################################################
                // Position in School field
                DropDownField(),
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddTeacherDialog());
                  },
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
}
