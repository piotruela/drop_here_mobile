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
  final TextStyle button;
  final TextStyle clickableText;

  final TextStyle dhButton;
  final TextStyle cardCaption;
  final TextStyle listTileTitle;
  final TextStyle cardSubtitle;
  final TextStyle popupMenu;
  final TextStyle active;
  final TextStyle blocked;

  TextStyleTheme({
    this.button,
    this.clickableText,
    this.primaryTitle,
    this.secondaryTitle,
    this.contentTitle,
    this.textFieldHint,
    this.dhButton,
    this.cardCaption,
    this.listTileTitle,
    this.cardSubtitle,
    this.popupMenu,
    this.active,
    this.blocked,
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
  final Color black;

  final Color listTileMenu;
  final Color listTileMenuIcon;
  final Color listTileMenuText;

  final Color addSthHere;

  ColorTheme(
      {this.black,
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
      this.addSthHere});
}
