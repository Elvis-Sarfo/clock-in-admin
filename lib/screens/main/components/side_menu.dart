import 'package:clock_in_admin/controllers/page_route_controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/dashboard/dashboard_screen.dart';
import 'package:clock_in_admin/screens/teachers/teachers_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'drawer_list_tile.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
                title: "Dashbord",
                leadingIcon: Icons.groups,
                press: () {
                  context
                      .read<PageRouteController>()
                      .navigate(DashboardScreen());
                  if (!Responsive.isDesktop(context)) {
                    Navigator.pop(context);
                  }
                }),
            DrawerListTile(
                title: "Attendance",
                leadingIcon: Icons.update,
                press: () {
                  context
                      .read<PageRouteController>()
                      .navigate(TeachersScreen(), title: 'Teachers');
                  if (!Responsive.isDesktop(context)) {
                    Navigator.pop(context);
                  }
                }),
            DrawerListTile(
              title: "Teacher",
              leadingIcon: Icons.people,
              press: () {},
            ),
            DrawerListTile(
              title: "Students",
              leadingIcon: Icons.groups,
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
      ),
    );
  }
}
