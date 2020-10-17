import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class ChosenRoundedFlatButton extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String text;

  ChosenRoundedFlatButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: themeConfig.colors.white,
        border: Border.all(color: themeConfig.colors.primary1),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          dhShadow(),
        ],
      ),
      child: Text(
        text,
        style: themeConfig.textStyles.coloredFlatButton,
      ),
    );
  }
}
