import 'package:clock_in_admin/controllers/page_route.controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/attendance/attendance.dart';
import 'package:clock_in_admin/screens/auth/login/login.dart';
import 'package:clock_in_admin/screens/dashboard/dashboard_screen.dart';
import 'package:clock_in_admin/screens/students/students_screen.dart';
import 'package:clock_in_admin/screens/teachers/teachers_screen.dart';
import 'package:clock_in_admin/services/auth_services.dart';
import 'package:clock_in_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_list_tile.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: [
        Image.asset("assets/images/nav_nachos@2x.png", height: double.infinity),
        Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
              title: "Dashboard",
              leadingIcon: Icons.group,
              press: () {
                context
                    .read<PageRouteController>()
                    .navigate(DashboardScreen(), title: 'Dashboard');
                if (!Responsive.isDesktop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            DrawerListTile(
              title: "Attendance",
              leadingIcon: Icons.update,
              press: () {
                context
                    .read<PageRouteController>()
                    .navigate(Attendance(), title: 'Attendance');
                if (!Responsive.isDesktop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            DrawerListTile(
              title: "Teacher",
              leadingIcon: Icons.people,
              press: () {
                context
                    .read<PageRouteController>()
                    .navigate(TeachersScreen(), title: 'Teachers');
                if (!Responsive.isDesktop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            DrawerListTile(
              title: "Students",
              leadingIcon: Icons.group,
              press: () {
                context
                    .read<PageRouteController>()
                    .navigate(StudentsScreen(), title: 'Students');
                if (!Responsive.isDesktop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            DrawerListTile(
              title: "Logout",
              leadingIcon: Icons.logout,
              press: () {
                Auth.signOutUser();
                Navigator.pop(context);
                sendToPage(context, Login());
              },
            ),
            // DrawerListTile(
            //   title: "Settings",
            //   leadingIcon: Icons.settings,
            //   press: () {},
            // ),
          ],
        ),
      ]),
    );
  }
}
