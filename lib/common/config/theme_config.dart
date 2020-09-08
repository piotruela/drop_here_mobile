import 'package:flutter/material.dart';

abstract class ThemeConfig {
  TextStyleTheme textStyles;
  ColorTheme colors;
  ThemeData primaryTheme();
}

class TextStyleTheme {
  final TextStyle primaryTitle;
  final TextStyle secondaryTitle;
  final TextStyle contentTitle;
  final TextStyle textFieldHint;
  final TextStyle dhButton;
  final TextStyle cardCaption;
  final TextStyle listTileTitle;

  TextStyleTheme({
    this.primaryTitle,
    this.secondaryTitle,
    this.contentTitle,
    this.textFieldHint,
    this.dhButton,
    this.cardCaption,
    this.listTileTitle,
  });
}

class ColorTheme {
  final Color primary1;
  final Color primary2;
  final Color secondary;
  final Color background;

  final Color facebookColor;
  final Color textFieldHint;

  final Color white;
  final Color listTileMenu;
  final Color listTileMenuIcon;
  final Color listTileMenuText;

  ColorTheme({
    this.background,
    this.primary1,
    this.primary2,
    this.secondary,
    this.facebookColor,
    this.textFieldHint,
    this.white,
    this.listTileMenu,
    this.listTileMenuIcon,
    this.listTileMenuText,
  });
}
