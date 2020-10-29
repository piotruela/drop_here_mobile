import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Text secondaryTitle(String text) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return Text(
    text,
    style: themeConfig.textStyles.secondaryTitle,
  );
}
