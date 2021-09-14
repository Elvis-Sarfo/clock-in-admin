import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomTileText extends StatelessWidget {
  final String title;
  final String? body;
  const CustomTileText({Key? key, required this.title, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Styles.h5,
          children: <TextSpan>[
            TextSpan(text: '${this.title}'),
            TextSpan(text: '\n'),
            TextSpan(
              text: '${this.body}',
              style: Styles.paragraph,
            ),
          ],
        ),
      ),
    );
  }
}
