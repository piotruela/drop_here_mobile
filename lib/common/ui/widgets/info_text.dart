import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoText extends StatelessWidget {
  final String text;
  final IconData iconType;

  const InfoText({this.text, this.iconType = Icons.info});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Row(
      children: [
        Icon(
          iconType,
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
