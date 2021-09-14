import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final Widget child;
  final String? title;
  const ChartCard({
    this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Styles.defaultPadding),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Styles.defaultPadding),
          child,
          // StorageInfoCard(
          //   svgSrc: "assets/icons/Documents.svg",
          //   title: "Documents Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media Files",
          //   amountOfFiles: "15.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 140,
          // ),
        ],
      ),
    );
  }
}
