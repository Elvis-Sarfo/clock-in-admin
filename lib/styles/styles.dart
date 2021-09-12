import 'package:flutter/material.dart';

class Styles {
  // 3d8c95
  // 225675
  // E6873C
  // 265874
  // https://youtu.be/9NBBk10axME

  // COLORS
  static const primaryDarkColor = Color(0xFF051e34);
  static const primaryColor = Color(0xFF870A4F);
  static const secondaryColor = Color(0xFF265878);
  // static const secondaryColor = Color(0xFF3d8c95);
  static const complementaryColor = Color(0xFFE6873C);
  static const backgroundColor = Color(0xFFEFF2F8);
  // static const backgroundColor = Color(0xFF225675);

  // PADDINGS
  static const defaultPadding = 16.0;

  // TEXT STYLES
  static const h5 = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: Styles.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const paragraph = TextStyle(
    fontSize: 18,
    height: 1.5,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  // SHADOWS
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      spreadRadius: 1.0,
      color: Styles.primaryColor.withOpacity(0.10),
      blurRadius: 20.0,
    ),
  ];

  // BORDERS
  static final Border border = Border.all(
    width: 2,
    color: Styles.primaryDarkColor.withOpacity(0.20),
  );

  static const radius10 = const BorderRadius.all(Radius.circular(10));

  // CARD
  static final cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: radius10,
    border: border,
    boxShadow: cardShadow,
  );
}
