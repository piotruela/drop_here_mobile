import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class ColoredRoundedFlatButton extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String text;
  final Function onTap;
  final TextStyle style;

  ColoredRoundedFlatButton({this.text, this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            dhShadow(),
          ],
        ),
        child: Text(
          text,
          style: style ?? themeConfig.textStyles.coloredFlatButton,
        ),
      ),
    );
  }
}
