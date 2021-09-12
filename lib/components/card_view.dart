import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final Color? color;
  final double? elevation;
  final EdgeInsetsGeometry? margin;

  CardView({this.onTap, this.child, this.color, this.elevation, this.margin});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      color: color,
      child: InkWell(
        splashColor: Colors.grey[200],
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
          child: child,
        ),
      ),
    );
  }
}
