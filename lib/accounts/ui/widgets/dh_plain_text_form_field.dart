import 'package:flutter/material.dart';

class DhPlainTextFormField extends StatelessWidget {
  final String hintText;
  final InputType inputType;
  final void Function(String) onChanged;
  final String initialValue;
  const DhPlainTextFormField({this.hintText, this.inputType, this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        //TODO add initial value
        onChanged: onChanged,
        keyboardType: inputType == InputType.number ? TextInputType.number : null,
        cursorColor: Colors.black,
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
}

enum InputType { text, number }
