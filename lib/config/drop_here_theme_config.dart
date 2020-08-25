import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class DHThemeConfig extends ThemeConfig {
  @override
  ThemeData primaryTheme() {
    ThemeData baseTheme = ThemeData.light();

    return baseTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.indigo,
      tabBarTheme: TabBarTheme(
        labelStyle: tab_Bar_Inactive,
        unselectedLabelStyle: tab_Bar_Inactive,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.black12,
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
      textTheme: baseTheme.textTheme.copyWith(
        subtitle1: const TextStyle(
            fontSize: 15.0,
            height: 20.0,
            letterSpacing: -0.24,
            fontFamily: 'SFProText',
            color: Color.fromRGBO(0, 0, 0, 1.0)),
        subtitle2: const TextStyle(
            fontSize: 13.0,
            height: 18.0,
            letterSpacing: -0.08,
            fontFamily: 'SFProText',
            color: Color.fromRGBO(60, 60, 67, 1.0)),
        headline6: const TextStyle(
            fontSize: 17.0,
            height: 22.0,
            letterSpacing: -0.41,
            fontFamily: 'SFProText',
            color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextStyle get tab_Bar_Inactive =>
      TextStyle(color: Colors.black12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 14.0);
}
