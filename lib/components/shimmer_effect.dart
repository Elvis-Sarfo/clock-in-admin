import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder? shapeBorder;

  const ShimmerEffect.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: Styles.radius10,
          side: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        );

  const ShimmerEffect.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[200]!,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder!,
          ),
        ),
      );
}
