import 'package:flutter/material.dart';

class DhTextArea extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;
  final String value;
  DhTextArea({this.hintText, this.onChanged, this.value});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        //TODO add controller
        onChanged: onChanged,
        cursorColor: Colors.black,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          suffixIcon: value != null && value != ''
              ? IconButton(
                  onPressed: () => _controller.clear(),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ))
              : null,
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
