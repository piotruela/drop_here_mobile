import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoText extends StatelessWidget {
  final String text;

  const InfoText({this.text});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Row(
      children: [
        Icon(
          Icons.info,
          size: 15.0,
        ),
        Text(
          text,
          style: themeConfig.textStyles.cardSubtitle,
        )
      ],
    );
  }
}
