import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon, suffixIcon;
  final String? hintText;
  final int? maxLines, minLines;
  final TextEditingController? controller;
  final TextInputType? type;
  final bool? isPasswordFeild;
  final String? Function(String? value)? onChange, validator, onSaved;
  // final Function(String value) onSaved;
  CustomTextFormField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.controller,
    this.onChange,
    this.onSaved,
    this.validator,
    this.type,
    this.maxLines = 1,
    this.minLines = 1,
    this.isPasswordFeild = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: TextFormField(
        controller: controller ?? null,
        onChanged: onChange ?? (value) {},
        validator: validator ??
            (value) {
              return null;
            },
        onSaved: onSaved ?? (value) {},
        keyboardType: type,
        maxLines: maxLines,
        obscureText: isPasswordFeild ?? false,
        minLines: minLines,
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
      ),
    );
  }
}
