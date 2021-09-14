import 'package:clock_in_admin/styles/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<PieChartSectionData>? sections;
  final int? total, value;
  const Chart({
    this.sections,
    this.total = 0,
    this.value = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: sections,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Styles.defaultPadding),
                Text(
                  "$value",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of $total"),
                Text("Present")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 10,
    showTitle: false,
    radius: 16,
  ),
];
