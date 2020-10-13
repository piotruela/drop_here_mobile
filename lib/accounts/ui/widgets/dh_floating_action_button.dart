import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dhFloatingButton({String text, Function onPressed, @required bool enabled}) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return FloatingActionButton.extended(
    onPressed: onPressed,
    label: Text(
      text,
      style:
          TextStyle(color: enabled ? themeConfig.colors.primary1 : themeConfig.colors.addSthHere),
    ),
    backgroundColor: themeConfig.colors.white,
  );
}
