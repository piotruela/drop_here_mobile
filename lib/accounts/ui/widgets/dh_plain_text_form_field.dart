import 'package:flutter/material.dart';

class DhPlainTextFormField extends StatelessWidget {
  final String hintText;
  final InputType inputType;
  final void Function(String) onChanged;
  final VoidCallback onSuffixPressed;
  final String initialValue;
  final bool isRequired;
  const DhPlainTextFormField(
      {this.hintText,
      this.isRequired = false,
      this.inputType,
      this.onChanged,
      this.initialValue,
      this.onSuffixPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: inputType == InputType.number ? TextInputType.number : null,
        cursorColor: Colors.black,
        validator: isRequired ? (value) => validator(value) : null,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Value is required';
    }
    return null;
  }
}

enum InputType { text, number }
