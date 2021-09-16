import 'package:clock_in_admin/controllers/menu.controller.dart';
import 'package:clock_in_admin/controllers/page_route.controller.dart';
import 'package:clock_in_admin/controllers/student.controller.dart';
import 'package:clock_in_admin/controllers/teacher.controller.dart';
import 'package:clock_in_admin/screens/auth/login/login.dart';
import 'package:clock_in_admin/screens/main/main_screen.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuController>(
          create: (context) => MenuController(),
        ),
        ChangeNotifierProvider<PageRouteController>(
          create: (context) => PageRouteController(),
        ),
        ChangeNotifierProvider<TeacherController>(
          create: (context) => TeacherController(),
        ),
        // ChangeNotifierProvider<TeacherAttendanceController>(
        //   create: (context) => TeacherAttendanceController(context: context),
        // ),
        ChangeNotifierProvider<StudentController>(
          create: (context) => StudentController(),
        ),
        // ChangeNotifierProvider<StudentAttendanceController>(
        //   create: (context) => StudentAttendanceController(context: context),
        // ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clockin Admin',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: Styles.backgroundColor,
      //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      //       .apply(bodyColor: Colors.black87),
      //   canvasColor: Styles.primaryColor,
      //   cardTheme: CardTheme(color: Styles.secondaryColor),
      // ),
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.backgroundColor,
        cardTheme: CardTheme(color: Styles.secondaryColor),
        canvasColor: Styles.primaryColor,
        primaryColor: Styles.primaryColor,
        primaryColorDark: Styles.primaryColor,
        backgroundColor: Styles.primaryColor,
        buttonTheme: ButtonThemeData(
          buttonColor: Styles.primaryColor,
        ),
      ),
      home: FirebaseAuth.instance.currentUser == null ? Login() : MainScreen(),
    );
  }
}
