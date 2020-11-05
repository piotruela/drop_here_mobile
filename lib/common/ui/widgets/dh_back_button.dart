import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DhBackButton extends StatelessWidget {
  final EdgeInsets padding;

  const DhBackButton({this.padding = const EdgeInsets.all(12.0)});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: padding,
        child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 40.0,
            ),
            onPressed: () => Get.back()),
      ),
    );
  }
}
