import 'package:clock_in_admin/constants.dart';
import 'package:clock_in_admin/controllers/menu_controller.dart';
import 'package:clock_in_admin/controllers/page_route_controller.dart';
import 'package:clock_in_admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clockin Admin',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<MenuController>(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProvider<PageRouteController>(
            create: (context) => PageRouteController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
