import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class SelectOptionField extends StatefulWidget {
  SelectOptionField({Key? key, this.prefixIcon, this.suffixIcon, this.hintText})
      : super(key: key);
  final Widget? prefixIcon, suffixIcon;
  final String? hintText;
  @override
  _SelectOptionFieldState createState() => _SelectOptionFieldState();
}

class _SelectOptionFieldState extends State<SelectOptionField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: 'One',
      onChanged: (value) {},
      onSaved: (value) {},
      hint: Text(
        'choose one',
      ),
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        filled: true,
        suffixIcon: widget.suffixIcon,
        fillColor: Styles.primaryColor.withOpacity(0.1),
        focusColor: Styles.primaryColor.withOpacity(0.2),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: widget.hintText != null ? widget.hintText : '',
      ),
      items: [
        DropdownMenuItem(
          value: 'One',
          child: Text('One '),
        ),
        DropdownMenuItem(
          value: 'Two',
          child: Text('Two '),
        ),
        DropdownMenuItem(
          value: 'Three',
          child: Text('Three '),
        ),
      ],
    );
  }
}
