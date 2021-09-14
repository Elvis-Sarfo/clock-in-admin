import 'package:clock_in_admin/controllers/page_route.controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/dashboard/dashboard_screen.dart';
import 'package:clock_in_admin/screens/teachers/teachers_screen.dart';
import 'package:clock_in_admin/screens/teachers_attendance/teachers_attendance_screen.dart';
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
              title: "Dashbord",
              leadingIcon: Icons.group,
              press: () {
                context.read<PageRouteController>().navigate(DashboardScreen());
                if (!Responsive.isDesktop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            DrawerListTile(
              title: "Attendance",
              leadingIcon: Icons.update,
              press: () {
                context.read<PageRouteController>().navigate(
                    TeachersAttendanceScreen(),
                    title: 'Teachers Attendance');
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
              press: () {},
            ),
            DrawerListTile(
              title: "Profile",
              leadingIcon: Icons.person,
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              leadingIcon: Icons.settings,
              press: () {},
            ),
          ],
        ),
      ]),
    );
  }
}
