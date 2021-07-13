import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/teachers/add_teacher_dialog.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class TeacherScreenMetaInfo extends StatelessWidget {
  const TeacherScreenMetaInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Styles.defaultPadding),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: Styles.defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Styles.complementaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: Styles.defaultPadding * 1.5,
                  vertical: Styles.defaultPadding /
                      (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddTeacherDialog(),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          )
        ],
      ),
    );
  }
}
