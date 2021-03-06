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
  final TextStyle filledTextField;

  final TextStyle dhButton;
  final TextStyle cardCaption;
  final TextStyle listTileTitle;
  final TextStyle cardSubtitle;
  final TextStyle popupMenu;
  final TextStyle active;
  final TextStyle blocked;
  final TextStyle coloredFlatButton;
  final TextStyle managementListTile;
  final TextStyle category;
  final TextStyle dataAnnotation;
  final TextStyle data;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle title3Annotation;
  final TextStyle flatButtonOff;
  final TextStyle bigColoredButtonActiveTextStyle;
  final TextStyle bigColoredButtonNotActiveTextStyle;
  final TextStyle valueChosenFlatButtonTextStyle;
  final TextStyle submitButtonTextStyle;
  final TextStyle smallSecondaryTitle;

  TextStyleTheme({
    this.button,
    this.clickableText,
    this.filledTextField,
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
    this.coloredFlatButton,
    this.managementListTile,
    this.category,
    this.dataAnnotation,
    this.data,
    this.title2,
    this.title3,
    this.title3Annotation,
    this.flatButtonOff,
    this.bigColoredButtonActiveTextStyle,
    this.bigColoredButtonNotActiveTextStyle,
    this.valueChosenFlatButtonTextStyle,
    this.submitButtonTextStyle,
    this.smallSecondaryTitle,
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
  final Color active;
  final Color blocked;
  final Color pending;

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
      this.addSthHere,
      this.active,
      this.blocked,
      this.pending});
}
