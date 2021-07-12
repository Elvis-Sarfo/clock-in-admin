import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Function(bool? value)? onChanged;
  final bool? isSwitched;
  CustomSwitch({Key? key, this.onChanged, this.isSwitched = false})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = widget.isSwitched!;
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        widget.onChanged!(value);
        setState(() {
          isSwitched = value;
        });
      },
      activeTrackColor: Styles.primaryColor,
      activeColor: Styles.primaryColor,
    );
  }
}
