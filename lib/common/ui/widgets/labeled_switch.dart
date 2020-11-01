import 'package:drop_here_mobile/accounts/ui/widgets/dh_switch.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget labeledSwitch({String text, bool initialPosition, Function(bool) onSwitch}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      secondaryTitle(text),
      DhSwitch(
        initialPosition: initialPosition ?? false,
        onSwitch: onSwitch,
      ),
    ],
  );
}

Text secondaryTitle(String text) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return Text(
    text,
    style: themeConfig.textStyles.secondaryTitle,
  );
}
