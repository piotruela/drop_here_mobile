import 'package:flutter/material.dart';

class DhPlainTextFormField extends StatelessWidget {
  final String hintText;
  final InputType inputType;
  final void Function(String) onChanged;
  final VoidCallback onSuffixPressed;
  final String initialValue;
  const DhPlainTextFormField(
      {this.hintText, this.inputType, this.onChanged, this.initialValue, this.onSuffixPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: inputType == InputType.number ? TextInputType.number : null,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          /*suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed:
                  onSuffixPressed),*/ //TODO:Uncomment when fixed
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
