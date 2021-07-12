import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'components/teachers_table.dart';
import 'components/teacher_screen_meta_info.dart';

class TeachersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          children: [
            SizedBox(height: Styles.defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      TeachersTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: Styles.defaultPadding),
                      if (Responsive.isMobile(context))
                        TeacherScreenMetaInfo(
                          key: null,
                        ),
                    ],
                  ),
                ),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  SizedBox(width: Styles.defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: TeacherScreenMetaInfo(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}