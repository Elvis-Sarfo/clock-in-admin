import 'package:clock_in_admin/models/card_info.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DashboardInfoCard extends StatelessWidget {
  const DashboardInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CardInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Styles.defaultPadding),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Styles.defaultPadding * 0.5,
                  vertical: 0,
                ),
                // height: 40,
                // width: 40,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  '${info.percentage?.toStringAsFixed(2) ?? 0}%',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.black54)
            ],
          ),
          Text(
            info.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          ProgressLine(
            color: info.color,
            percentage: info.percentage ?? 0,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${info.numOfFiels} ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "out of "),
                TextSpan(
                  text: "${info.totalNumOfTeachers} ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "teachers"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = Styles.primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
