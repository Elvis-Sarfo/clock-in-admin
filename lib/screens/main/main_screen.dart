import 'package:clock_in_admin/controllers/menu_controller.dart';
import 'package:clock_in_admin/controllers/page_route_controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    child: context.watch<PageRouteController>().route,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
