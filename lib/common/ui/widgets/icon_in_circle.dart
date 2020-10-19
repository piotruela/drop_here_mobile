import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class IconInCircle extends StatelessWidget {
  final IconData icon;
  final ThemeConfig themeConfig;
  const IconInCircle({
    @required this.themeConfig,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: themeConfig.colors.black,
        radius: 25,
        child: CircleAvatar(
            backgroundColor: themeConfig.colors.white,
            radius: 23,
            child: Icon(
              icon,
              size: 30,
              color: themeConfig.colors.primary1,
            )));
  }
}
