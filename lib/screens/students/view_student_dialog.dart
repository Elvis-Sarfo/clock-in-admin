import 'package:clock_in_admin/components/circular_image.dart';
import 'package:clock_in_admin/models/guardian.dart';
import 'package:clock_in_admin/models/student.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

import 'components/cus_tile_test.dart';

class ViewStudentDialog extends StatelessWidget {
  final Student? student;
  late final Guardian _guardian;
  ViewStudentDialog({Key? key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _guardian = Guardian.fromMapObject(student!.guardian);
    return SimpleDialog(
      titlePadding:
          EdgeInsets.symmetric(horizontal: Styles.defaultPadding, vertical: 5),
      backgroundColor: Styles.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Student Details'),
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
          child: Column(
            children: [
              student?.picture != null
                  ? CircularImage(
                      child: Image.network(student!.picture!),
                      width: 120,
                      height: 120,
                    )
                  : CircularImage(
                      child: Image.asset(
                        student!.gender!.toLowerCase() == 'male'
                            ? 'assets/images/student_male-no-bg.png'
                            : 'assets/images/student-female-no-bg.png',
                      ),
                      width: 120,
                      height: 120,
                    ),
              SizedBox(height: 10),
              Divider(color: Colors.black12),
              CustomTileText(title: 'Student ID', body: student?.id ?? ''),
              Divider(color: Colors.black12),
              CustomTileText(
                  title: 'Full Name', body: student?.fullName() ?? ''),
              Divider(color: Colors.black12),
              CustomTileText(
                  title: 'Gender', body: student?.gender!.toUpperCase() ?? ''),
              Divider(color: Colors.black12),
              CustomTileText(
                  title: 'Residence', body: student?.residence ?? ''),
              Divider(color: Colors.black12),
              CustomTileText(title: 'Course', body: student?.course ?? ''),
              Divider(color: Colors.black12),
              CustomTileText(
                  title: 'Position', body: student?.position ?? 'None'),
              Divider(color: Colors.black12),
              Text(
                'Guardian Detials',
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ),
              CustomTileText(
                  title: 'Guardian Name', body: _guardian.fullName() ?? 'None'),
              CustomTileText(
                  title: 'Guardian Phone Number',
                  body: _guardian.phone ?? 'None'),
              CustomTileText(
                  title: 'Guardian Email', body: _guardian.email ?? 'None'),
              CustomTileText(
                  title: 'Realationship with Student',
                  body: _guardian.relationship ?? 'None'),
              CustomTileText(
                  title: 'Guardian Residence',
                  body: _guardian.residence ?? 'None'),
              CustomTileText(
                  title: 'Guardian Gender',
                  body: _guardian.gender?.toUpperCase() ?? 'None'),
            ],
          ),
        ),
      ],
    );
  }
}
