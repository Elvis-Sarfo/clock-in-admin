import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final Image? child;
  const CircularImage({Key? key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
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
