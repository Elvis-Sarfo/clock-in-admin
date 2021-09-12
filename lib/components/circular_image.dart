import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final Image? child;
  final double width, height;
  const CircularImage(
      {Key? key, @required this.child, this.width = 50, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(100.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: child ??
            Image.asset(
              'assets/images/farmer.png',
            ),
      ),
    );
  }
}
