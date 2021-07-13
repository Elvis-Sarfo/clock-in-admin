import 'package:clock_in_admin/components/labeled_radio_button.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  // final List options
  final String? Function(String? value)? onChanged, onSaved;
  final String? groupValue;
  const GenderSelector({
    Key? key,
    @required this.onChanged,
    this.onSaved,
    this.groupValue,
  }) : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? _groupVal;

  _onChangedHandler(String value) {
    widget.onChanged!(value);
    setState(() {
      _groupVal = value;
    });
  }

  @override
  void initState() {
    _groupVal = widget.groupValue ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: Styles.primaryColor.withOpacity(0.1),
          border: Styles.border,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Icon(
            Icons.wc,
            color: Colors.black54,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Gender ',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: LabeledRadioButton(
              label: 'Male',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: 'male',
              groupValue: _groupVal,
              onChanged: _onChangedHandler,
            ),
          ),
          Expanded(
            child: LabeledRadioButton(
              label: 'Female',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: 'female',
              groupValue: _groupVal,
              onChanged: _onChangedHandler,
            ),
          ),
        ],
      ),
    );
  }
}
