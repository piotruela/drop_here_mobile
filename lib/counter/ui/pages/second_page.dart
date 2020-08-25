import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Form Validation')),
        body: Container(
          child: Center(
            child: Text("INFOOO"),
          ),
        )
      ),
    );
  }
}