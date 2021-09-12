import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class TeacherAttendanceScreenMetaInfo extends StatelessWidget {
  const TeacherAttendanceScreenMetaInfo({
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
          // todo: Remove the following widget because it is not needed
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
                  builder: (context) => Container(),
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
