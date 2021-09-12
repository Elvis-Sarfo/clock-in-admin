import 'dart:async';

import 'package:clock_in_admin/services/cities_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadInput extends StatelessWidget {
  final Widget? prefixIcon, suffixIcon;
  final String? hintText;
  final FocusNode? focusNode;
  final int? maxLines, minLines;
  final TextEditingController? controller;
  final TextInputType? type;
  final String? Function(String? value)? validator, onSaved;
  final FutureOr<Iterable<String>> Function(String) suggestionsCallback;
  const TypeAheadInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    required this.controller,
    required this.suggestionsCallback,
    this.onSaved,
    this.validator,
    this.type,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: prefixIcon,
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: Colors.white,
          focusColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Styles.primaryColor.withOpacity(0.60),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Styles.primaryDarkColor.withOpacity(0.30),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red.withOpacity(0.30),
            ),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          //   borderSide: BorderSide(color: Colors.red, width: 5.0),
          // ),
          hintText: hintText != null ? hintText : '',
        ),
        controller: this.controller ?? null,
      ),
      suggestionsCallback: suggestionsCallback,
      itemBuilder: (context, String suggestion) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
          title: Text(
            suggestion,
            style: TextStyle(color: Styles.primaryColor),
          ),
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(color: Colors.white),
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (String suggestion) {
        this.controller!.text = suggestion;
      },
      noItemsFoundBuilder: (context) {
        return SizedBox.shrink();
      },
      onSaved: onSaved ?? (value) {},
      validator: validator ??
          (value) {
            return null;
          },
    );
  }
}
