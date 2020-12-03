import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';

class IconInCircle extends StatelessWidget {
  final IconData icon;
  final ThemeConfig themeConfig;
  final double size;
  const IconInCircle({
    @required this.themeConfig,
    this.icon,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: themeConfig.colors.black,
        radius: 25,
        child: CircleAvatar(
            backgroundColor: themeConfig.colors.white,
            radius: 24,
            child: Icon(
              icon,
              size: size,
              color: themeConfig.colors.primary1,
            )));
  }
}
