import 'package:clock_in_admin/components/shimmer_effect.dart';
import 'package:clock_in_admin/controllers/teacher.controller.dart';
import 'package:clock_in_admin/models/card_info.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_info_card.dart';

class DashboardInfo extends StatelessWidget {
  const DashboardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "My Files",
        //       style: Theme.of(context).textTheme.subtitle1,
        //     ),
        //     ElevatedButton.icon(
        //       style: TextButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: Styles.defaultPadding * 1.5,
        //           vertical: Styles.defaultPadding /
        //               (Responsive.isMobile(context) ? 2 : 1),
        //         ),
        //       ),
        //       onPressed: () {},
        //       icon: Icon(Icons.add),
        //       label: Text("Add New"),
        //     ),
        //   ],
        // ),
        // SizedBox(height: Styles.defaultPadding),
        Responsive(
          mobile: DashboardInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: DashboardInfoCardGridView(),
          desktop: DashboardInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class DashboardInfoCardGridView extends StatelessWidget {
  const DashboardInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherController>(
      builder: (context, attendanceState, child) {
        if (attendanceState.hasError) {
          return Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(child: Text('Something went wrong')),
          );
        }
        if (attendanceState.waiting) {
          return GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: Styles.defaultPadding,
              mainAxisSpacing: Styles.defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            children: [
              ShimmerEffect.rectangular(height: 80),
              ShimmerEffect.rectangular(height: 80),
              ShimmerEffect.rectangular(height: 80),
              ShimmerEffect.rectangular(height: 80),
            ],
          );
        }
        return GridView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: Styles.defaultPadding,
            mainAxisSpacing: Styles.defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          children: [
            DashboardInfoCard(
              info: CardInfo(
                title: "Present",
                numOfFiels: attendanceState.numOfPresentTeachers,
                totalNumOfTeachers: attendanceState.totalNumOfTeachers,
                color: Colors.green,
                percentage: ((attendanceState.numOfPresentTeachers /
                        attendanceState.totalNumOfTeachers) *
                    100),
              ),
            ),
            DashboardInfoCard(
              info: CardInfo(
                title: "Absentees",
                numOfFiels: attendanceState.numOfAbsentTeachers,
                totalNumOfTeachers: attendanceState.totalNumOfTeachers,
                color: Colors.red,
                percentage: ((attendanceState.numOfAbsentTeachers /
                        attendanceState.totalNumOfTeachers) *
                    100),
              ),
            ),
            DashboardInfoCard(
              info: CardInfo(
                title: "On Campus",
                numOfFiels: attendanceState.numOfTeachersOnCampus,
                totalNumOfTeachers: attendanceState.totalNumOfTeachers,
                color: Colors.indigo,
                percentage: ((attendanceState.numOfTeachersOnCampus /
                        attendanceState.totalNumOfTeachers) *
                    100),
              ),
            ),
            DashboardInfoCard(
              info: CardInfo(
                title: "Out of Campus",
                numOfFiels: attendanceState.numOfTeachersOutCampus,
                totalNumOfTeachers: attendanceState.totalNumOfTeachers,
                color: Color(0xFFFFA113),
                percentage: ((attendanceState.numOfTeachersOutCampus /
                        attendanceState.totalNumOfTeachers) *
                    100),
              ),
            ),
          ],
        );
      },
    );
  }
}
