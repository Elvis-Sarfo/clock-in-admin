import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? title, code, msg;
  const ErrorMessage({
    Key? key,
    this.code,
    this.title,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: Styles.defaultPadding,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Styles.defaultPadding,
        vertical: Styles.defaultPadding,
      ),
      decoration: Styles.errorCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              '${title ?? ''} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          if (code != null)
            Text(
              '${code ?? ''} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          Text('${msg ?? ''} '),
        ],
      ),
    );
  }
}
