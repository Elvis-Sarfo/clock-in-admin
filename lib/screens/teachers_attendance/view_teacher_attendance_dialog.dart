import 'package:clock_in_admin/components/image_chooser.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

import 'components/cus_tile_test.dart';

class ViewTeacherAttendanceDialog extends StatelessWidget {
  ViewTeacherAttendanceDialog({Key? key}) : super(key: key);
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
          Text('TeacherAttendance Details'),
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
                ImageChooser(
                  onImageSelected: (image) async {
                    // profileImage = image;
                  },
                ),
                SizedBox(height: 10),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
                CustomTileText(title: 'Full Name', body: 'Elvis Antwi Sarfo'),
                Divider(color: Colors.white10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
