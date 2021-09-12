import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String? text1;
  final String? text2;
  final TextStyle? textStyle1;
  final TextStyle? textStyle2;
  ClickableText(
      {Key? key, this.text1, this.text2, this.textStyle1, this.textStyle2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: text1, style: textStyle1),
      TextSpan(text: text2, style: textStyle2),
    ]));
  }
}
