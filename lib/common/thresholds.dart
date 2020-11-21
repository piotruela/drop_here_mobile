import 'package:flutter/cupertino.dart';

class Thresholds {
  static const double width = 370;
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
