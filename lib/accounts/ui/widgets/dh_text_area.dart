import 'package:flutter/material.dart';

class DhTextArea extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;
  DhTextArea({this.hintText, this.onChanged});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        onChanged: onChanged,
        //controller: _controller,
        cursorColor: Colors.black,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: () => _controller.clear(), icon: Icon(Icons.clear)),
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
