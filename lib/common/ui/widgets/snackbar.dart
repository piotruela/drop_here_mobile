import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackBar dhSnackBar(String text) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return SnackBar(
    content: Text(text),
    duration: Duration(seconds: 2),
    backgroundColor: themeConfig.colors.blocked,
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
  );
}
