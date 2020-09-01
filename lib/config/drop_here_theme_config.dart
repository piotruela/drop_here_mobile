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
      secondaryTitle: _secondaryTitleTextStyle,
      contentTitle: _contentTextStyle,
      textFieldHint: _textFieldHintTextStyle,
      dhButton: _dhButtonTextStyle,
    );
  }

  void _initColorTheme() {
    colors = ColorTheme(
      primary1: _primaryColor1,
      primary2: _primaryColor2,
      secondary: _secondaryColor,
      facebookColor: _facebookColor,
      textFieldHint: _textFieldHintColor,
      white: _white,
      background: _backgroundColor,
    );
  }

  static final TextStyle _baseTextStyle = TextStyle(fontFamily: 'Roboto', color: _secondaryColor, letterSpacing: 0.0, fontWeight: FontWeight.normal);
  static final TextStyle _primaryTitleTextStyle = _baseTextStyle.copyWith(fontSize: 30.0, height: 35.0 / 30.0, fontWeight: FontWeight.bold);
  static final TextStyle _secondaryTitleTextStyle = _baseTextStyle.copyWith(fontSize: 18.0, height: 21.0 / 18.0, fontWeight: FontWeight.bold);
  static final TextStyle _dhButtonTextStyle = _baseTextStyle.copyWith(color: _dhButtonTextColor, fontSize: 18.0, height: 21.0 / 18.0, fontWeight: FontWeight.bold);
  static final TextStyle _contentTextStyle = _baseTextStyle.copyWith(fontSize: 14.0, height: 16.0 / 14.0, fontWeight: FontWeight.bold);
  static final TextStyle _textFieldHintTextStyle = _baseTextStyle.copyWith(fontSize: 18.0, color: _textFieldHintColor, height: 21.0 / 18.0, fontWeight: FontWeight.bold);

  static final Color _primaryColor1 = const Color(0xfff5550a);
  static final Color _primaryColor2 = const Color(0xfff99363);

  static final Color _secondaryColor = const Color(0xff000000);
  static final Color _backgroundColor = const Color(0xffffffff);

  static final Color _facebookColor = const Color(0xff3b5998);
  static final Color _textFieldHintColor = const Color(0xff8d8d8d);

  static final Color _dhButtonTextColor = const Color(0xffffffff);

  static final Color _white = const Color (0xffffffff);
}
