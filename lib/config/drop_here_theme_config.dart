import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DHThemeConfig extends ThemeConfig {
  @override
  TextStyleTheme textStyles;

  @override
  ColorTheme colors;

  DHThemeConfig() {
    _initTextStyleTheme();
    _initColorTheme();
  }

  @override
  ThemeData primaryTheme() {
    ThemeData baseTheme = ThemeData.light();

    return baseTheme;
  }

  void _initTextStyleTheme() {
    textStyles = TextStyleTheme(
      primaryTitle: _primaryTitleTextStyle,
      filledTextField: _filledTextField,
      secondaryTitle: _secondaryTitleTextStyle,
      contentTitle: _contentTextStyle,
      textFieldHint: _textFieldHintTextStyle,
      button: _buttonTextStyle,
      clickableText: _clickableTextStyle,
      dhButton: _dhButtonTextStyle,
      cardCaption: _cardCaptionTextStyle,
      listTileTitle: _listTileTitleTextStyle,
      cardSubtitle: _cardSubtitleTextStyle,
      popupMenu: _popupMenuTextStyle,
      active: _activeTextStyle,
      blocked: _blockedTextStyle,
      coloredFlatButton: _coloredFlatButtonTextStyle,
      managementListTile: _managementListTileTextStyle,
    );
  }

  void _initColorTheme() {
    colors = ColorTheme(
      primary1: _primaryColor1,
      primary2: _primaryColor2,
      facebookColor: _facebookColor,
      textFieldHint: _textFieldHintColor,
      white: _white,
      black: _black,
      background: _backgroundColor,
      listTileMenu: _listTileMenuColor,
      listTileMenuIcon: _listTileMenuIconColor,
      listTileMenuText: _listTileMenuTextColor,
      addSthHere: _addSthHereColor,
      active: _activeColor,
      blocked: _blockedColor,
    );
  }

  static final TextStyle _buttonTextStyle = _secondaryTitleTextStyle.copyWith(color: _white);
  static final TextStyle _clickableTextStyle = _baseTextStyle.copyWith(
      fontSize: 14.0,
      color: _primaryColor1,
      height: 21.0 / 18.0,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline);

  static final TextStyle _baseTextStyle = TextStyle(
      fontFamily: 'Roboto', color: _black, letterSpacing: 0.0, fontWeight: FontWeight.normal);

  static final TextStyle _primaryTitleTextStyle =
      _baseTextStyle.copyWith(fontSize: 30.0, height: 35.0 / 30.0, fontWeight: FontWeight.bold);
  static final TextStyle _secondaryTitleTextStyle =
      _baseTextStyle.copyWith(fontSize: 18.0, height: 21.0 / 18.0, fontWeight: FontWeight.bold);
  static final TextStyle _dhButtonTextStyle = _baseTextStyle.copyWith(
      color: _dhButtonTextColor, fontSize: 18.0, height: 21.0 / 18.0, fontWeight: FontWeight.bold);
  static final TextStyle _contentTextStyle =
      _baseTextStyle.copyWith(fontSize: 14.0, height: 16.0 / 14.0, fontWeight: FontWeight.bold);
  static final TextStyle _textFieldHintTextStyle = _baseTextStyle.copyWith(
      fontSize: 18.0, color: _textFieldHintColor, height: 21.0 / 18.0, fontWeight: FontWeight.bold);
  static final TextStyle _cardCaptionTextStyle = _baseTextStyle.copyWith(
      fontSize: 20.0, color: _white, height: 23.0 / 20.0, fontWeight: FontWeight.bold);

  static final TextStyle _filledTextField =
      _secondaryTitleTextStyle.copyWith(color: _black, fontWeight: FontWeight.normal);

  static final TextStyle _listTileTitleTextStyle = _baseTextStyle.copyWith(
      fontSize: 20.0,
      color: _listTileMenuTextColor,
      height: 23.0 / 20.0,
      fontWeight: FontWeight.bold);

  static final TextStyle _cardSubtitleTextStyle = _baseTextStyle.copyWith(
      fontSize: 12.0,
      color: _listTileMenuTextColor,
      height: 14.0 / 12.0,
      fontWeight: FontWeight.w300);

  static final TextStyle _popupMenuTextStyle =
      _baseTextStyle.copyWith(fontSize: 12.0, height: 14.0 / 12.0, fontWeight: FontWeight.w400);

  static final TextStyle _activeTextStyle = _baseTextStyle.copyWith(
      fontSize: 12.0, height: 14.0 / 12.0, fontWeight: FontWeight.w500, color: _activeColor);
  static final TextStyle _blockedTextStyle = _baseTextStyle.copyWith(
      fontSize: 12.0, height: 14.0 / 12.0, fontWeight: FontWeight.w500, color: _blockedColor);
  static final TextStyle _coloredFlatButtonTextStyle =
      _baseTextStyle.copyWith(fontSize: 14.0, height: 16.0 / 14.0, color: _primaryColor1);
  static final TextStyle _managementListTileTextStyle =
      _baseTextStyle.copyWith(fontSize: 18.0, height: 21.0 / 18.0, color: _listTileMenuIconColor);

  static final Color _primaryColor1 = const Color(0xfff5550a);
  static final Color _primaryColor2 = const Color(0xfff99363);

  static final Color _backgroundColor = const Color(0xfff9f9f9);

  static final Color _facebookColor = const Color(0xff3b5998);
  static final Color _textFieldHintColor = const Color(0xff8d8d8d);
  static final Color _addSthHereColor = const Color(0xffe0e0e0);

  static final Color _white = const Color(0xffffffff);

  static final Color _black = const Color(0xff000000);
  static final Color _dhButtonTextColor = _white;

  static final Color _listTileMenuColor = const Color(0xfff2f2f2);
  static final Color _listTileMenuIconColor = const Color(0xff828282);
  static final Color _listTileMenuTextColor = const Color(0xff8D8D8D);

  static final Color _activeColor = const Color(0xff029519);
  static final Color _blockedColor = const Color(0xffAA0E04);
}
