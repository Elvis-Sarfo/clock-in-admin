import 'package:clock_in_admin/screens/students_attendance/components/students_attendance_table.dart';
import 'package:clock_in_admin/screens/teachers_attendance/components/teachers_attendance_table.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);
  @override
  State<TabView> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<TabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          backgroundColor: Styles.primaryColor.withOpacity(0.90),
          title: Text(
            'Attendance Log for Today',
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          bottom: TabBar(
            labelColor: Styles.primaryColor,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(
                  10,
                ),
              ),
              color: Colors.white,
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "TEACHERS",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "STUDENTS",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TeachersAttendancesTable(isTabbed: true),
            StudentsAttendancesTable(isTabbed: true),
          ],
        ),
      ),
    );
  }
}
