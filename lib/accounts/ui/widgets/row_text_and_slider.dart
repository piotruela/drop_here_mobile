import 'package:drop_here_mobile/accounts/ui/widgets/dh_switch.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding rowTextAndSlider({String text, Function onToggle}) {
  return Padding(
    padding: const EdgeInsets.only(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        secondaryTitle(text),
        DhSwitch(
          initialPosition: false,
          onSwitch: onToggle,
        ),
      ],
    ),
  );
}

Text secondaryTitle(String text) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return Text(
    text,
    style: themeConfig.textStyles.secondaryTitle,
  );
}
