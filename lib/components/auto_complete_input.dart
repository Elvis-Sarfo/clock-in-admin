/// Flutter code sample for Autocomplete

// This example shows how to create a very basic Autocomplete widget using the
// default UI.

import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';

class AutocompleteBasicExample extends StatelessWidget {
  final String? Function(String? value)? onChange, validator, onSaved;
  final Widget? prefixIcon, suffixIcon;
  const AutocompleteBasicExample({
    Key? key,
    this.onChange,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: _fieldViewBuilder,
      optionsViewBuilder: _optionsViewBuilder,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }

  Widget _fieldViewBuilder(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    return CustomTextFormField(
      prefixIcon: Icon(Icons.person),
      hintText: 'Town of Residence',
      controller: textEditingController,
      focusNode: focusNode,
    );
  }

  Widget _optionsViewBuilder(BuildContext context,
      AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
    // Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Styles.primaryColor,
        textStyle: TextStyle(color: Colors.white),
        elevation: 4.0,
        child: Container(
          height: 100.0,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(option),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
