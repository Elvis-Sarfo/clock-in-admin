import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class LabeledRadioButton extends StatelessWidget {
  const LabeledRadioButton({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String? label;
  final EdgeInsets? padding;
  final String? groupValue;
  final String? value;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged!(value);
      },
      child: Padding(
        padding: padding!,
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value!,
              activeColor: Styles.primaryColor,
              toggleable: true,
              onChanged: (String? newValue) {
                onChanged!(newValue);
              },
            ),
            Flexible(child: Text(label ?? '')),
          ],
        ),
      ),
    );
  }
}
