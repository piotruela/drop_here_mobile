import 'package:flutter/material.dart';

abstract class ThemeConfig {
  TextStyleTheme textStyles;
  ColorTheme colors;
  ThemeData primaryTheme();
}

class TextStyleTheme{
  final TextStyle primaryTitle;
  final TextStyle secondaryTitle;
  final TextStyle contentTitle;
  final TextStyle textFieldHint;
  final TextStyle button;
  final TextStyle clickableText;

  TextStyleTheme({this.primaryTitle, this.secondaryTitle, this.contentTitle, this.textFieldHint, this.button, this.clickableText});
}


class ColorTheme{
  final Color primary1;
  final Color primary2;
  final Color secondary;

  final Color facebookColor;
  final Color textFieldHint;

  final Color white;
  final Color black;

  ColorTheme({this.primary1, this.primary2, this.secondary, this.facebookColor, this.textFieldHint, this.white, this
      .black});

}
