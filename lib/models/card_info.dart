import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class CardInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiels;
  final int? totalNumOfTeachers;
  final Color? color;
  final double? percentage;

  CardInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFiels,
      this.percentage = 0,
      this.totalNumOfTeachers,
      this.color});
}

List demoMyFiels = [
  CardInfo(
    title: "Present",
    numOfFiels: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: Colors.green,
    percentage: 35,
  ),
  CardInfo(
    title: "On Campus",
    numOfFiels: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: Styles.primaryColor,
    percentage: 35,
  ),
  CardInfo(
    title: "Out of Campus",
    numOfFiels: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CardInfo(
    title: "Absentees",
    numOfFiels: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
];
