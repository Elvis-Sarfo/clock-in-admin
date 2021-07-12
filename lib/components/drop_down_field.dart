import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  const DropDownField(
      {Key? key, this.prefixIcon, this.suffixIcon, this.hintText})
      : super(key: key);
  final Widget? prefixIcon, suffixIcon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField(
        value: 'One',
        onChanged: (value) {},
        onSaved: (value) {},
        hint: Text(
          'choose one',
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: Styles.primaryColor.withOpacity(0.1),
          focusColor: Styles.primaryColor.withOpacity(0.2),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: hintText != null ? hintText : '',
        ),
        isExpanded: false,
        dropdownColor: Colors.white,
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
      ),
    );
  }
}
