import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/models/teacher.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

import 'components/cus_tile_test.dart';

class ViewTeacherDialog extends StatelessWidget {
  final Teacher? teacher;
  ViewTeacherDialog({Key? key, this.teacher}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

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
          Text('Teacher Details'),
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
              : size.width * 0.3,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                teacher?.picture != null
                    ? CircularImage(
                        child: Image.network(teacher!.picture!),
                        width: 150,
                        height: 150,
                      )
                    : CircularImage(
                        child: Image.asset(
                          teacher!.gender!.toLowerCase() == 'male'
                              ? 'assets/images/teacher_male-no-bg.png'
                              : 'assets/images/teacher-female-no-bg.png',
                        ),
                        width: 100,
                        height: 100,
                      ),
                SizedBox(height: 10),
                Divider(color: Colors.black12),
                CustomTileText(title: 'Staff ID', body: teacher?.staffId ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Full Name', body: teacher?.fullName() ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Gender',
                    body: teacher?.gender!.toUpperCase() ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Town of Residence', body: teacher?.residence ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Phone Number', body: teacher?.phone ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(title: 'Email', body: teacher?.email ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Department', body: teacher?.department ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(title: 'Subject', body: teacher?.subject ?? ''),
                Divider(color: Colors.black12),
                CustomTileText(
                    title: 'Position in School', body: teacher?.position ?? ''),
                Divider(color: Colors.black12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
